#include "CoreFoundation/CFPropertyList.h"
#include "dynamicisland.h"
#include "sqlite3.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

static const char DBPATH_CMD[256] = {
    "lsof -p $(ps aux | grep -m1 usernoted | awk '{ print $2 }')| awk '{ print "
    "$NF }' | grep 'db2/db$'"};
char DBPATH[256];

struct notificationHelper {
  char command[512];
};

sqlite3 *db;
sqlite3_stmt *stmt;

int rc;
char *error_message = 0;

int lastNotifCount = 0;

static inline void
database_init(struct notificationHelper *notificationHelper) {
  // get notification database location
  FILE *output;
  output = popen(DBPATH_CMD, "r");
  if (!output) {
    return;
  }
  fgets(DBPATH, sizeof(DBPATH), output);
  // Remove trailing new line character from fgets
  DBPATH[strcspn(DBPATH, "\n")] = 0;
}

static inline void parse_notification_details(const UInt8 *rawData, int dataLen,
                                              char **title, char **subtitle,
                                              char **body) {
  CFDataRef ref = CFDataCreate(kCFAllocatorDefault, rawData, dataLen);

  if (ref) {
    CFDictionaryRef detailsPlist =
        (CFDictionaryRef)CFPropertyListCreateWithData(
            NULL, ref, kCFPropertyListMutableContainers, NULL, NULL);
    if (detailsPlist) {
      // First access req value dictionary
      CFStringRef key =
          CFStringCreateWithCString(NULL, "req", kCFStringEncodingUTF8);

      CFDictionaryRef req_dict =
          (CFDictionaryRef)CFDictionaryGetValue(detailsPlist, key);

      // Prepare to read values
      CFStringRef titl_key =
          CFStringCreateWithCString(NULL, "titl", kCFStringEncodingUTF8);
      CFStringRef subt_key =
          CFStringCreateWithCString(NULL, "subt", kCFStringEncodingUTF8);
      CFStringRef body_key =
          CFStringCreateWithCString(NULL, "body", kCFStringEncodingUTF8);

      // Read values
      CFStringRef titl_value =
          (CFStringRef)CFDictionaryGetValue(req_dict, titl_key);
      CFStringRef subt_value =
          (CFStringRef)CFDictionaryGetValue(req_dict, subt_key);
      CFStringRef body_value =
          (CFStringRef)CFDictionaryGetValue(req_dict, body_key);

      char titl_buffer[1024];
      if (titl_value) {
        if (CFStringGetCString(titl_value, titl_buffer, sizeof(titl_buffer),
                               kCFStringEncodingUTF8)) {
          *title = titl_buffer;
        }
      }

      char subt_buffer[1024];
      if (subt_value) {
        if (CFStringGetCString(subt_value, subt_buffer, sizeof(subt_buffer),
                               kCFStringEncodingUTF8)) {
          *subtitle = subt_buffer;
        }
      }

      char body_buffer[1024];
      if (body_value) {
        if (CFStringGetCString(body_value, body_buffer, sizeof(body_buffer),
                               kCFStringEncodingUTF8)) {
          *body = body_buffer;
        }
      }

      // Release
      CFRelease(titl_key);
      CFRelease(subt_key);
      CFRelease(body_key);
      CFRelease(key);
      CFRelease(detailsPlist);
    } else {
      // Failed to create plist with provided data
      fprintf(stderr, "Failed to create plist with provided data!");

      CFRelease(detailsPlist);
    }
  } else {
    fprintf(stderr, "Failed to create data ref with provided data!");
  }

  CFRelease(ref);
}

static inline struct islandItem *
check_notifications(struct notificationHelper *notificationHelper) {
  // Open the database
  rc = sqlite3_open_v2(DBPATH, &db, SQLITE_OPEN_READONLY, NULL);
  if (rc != SQLITE_OK) {
    fprintf(stderr, "Error opening database: %s\n", sqlite3_errmsg(db));

    rc = sqlite3_close(db);
    if (rc != SQLITE_OK) {
      fprintf(stderr, "Error closing database: %s\n", sqlite3_errmsg(db));
    }
    return NULL;
  }

  // Check notification count
  if (sqlite3_prepare_v2(db, "SELECT Count(*) FROM record", -1, &stmt, NULL) !=
      SQLITE_OK) {
    fprintf(stderr, "Error accessing database entry counts: %s\n",
            sqlite3_errmsg(db));

    sqlite3_finalize(stmt);

    // Close the database
    rc = sqlite3_close(db);
    if (rc != SQLITE_OK) {
      fprintf(stderr, "Error closing database: %s\n", sqlite3_errmsg(db));
    }

    return NULL;
  }

  // Get notificatoin count
  if (sqlite3_step(stmt) != SQLITE_DONE) {
    int notifCount = sqlite3_column_int(stmt, 0);

    if (notifCount > lastNotifCount) {

      // finalize previous statement
      sqlite3_finalize(stmt);

      // Prepare statement
      if (sqlite3_prepare_v2(
              db,
              "SELECT (SELECT identifier from app where "
              "app.app_id=record.app_id) "
              "as "
              "app, uuid, data, presented, delivered_date FROM record ORDER BY "
              "delivered_date DESC LIMIT 1",
              -1, &stmt, NULL) != SQLITE_OK) {

        fprintf(stderr, "Error preparing database: %s\n", sqlite3_errmsg(db));

        sqlite3_finalize(stmt);

        // Close the database
        rc = sqlite3_close(db);
        if (rc != SQLITE_OK) {
          fprintf(stderr, "Error closing database: %s\n", sqlite3_errmsg(db));
        }

        return NULL;
      }

      if (sqlite3_step(stmt) != SQLITE_DONE) {
        // Extract the desired information from the result set
        const char *app = (const char *)sqlite3_column_text(stmt, 0);

        const void *plist_data = sqlite3_column_blob(stmt, 2);
        int plist_data_len = sqlite3_column_bytes(stmt, 2);

        int presented = sqlite3_column_int(stmt, 3);
        const char *delivered_date = (const char *)sqlite3_column_text(stmt, 4);

        // TODO: HANDLE EXCEPTIONS PROPERLY
        if (strcmp(app, "com.apple.controlcenter.notifications.focus") == 0) {
          sqlite3_finalize(stmt);

          // Close the database
          rc = sqlite3_close(db);
          if (rc != SQLITE_OK) {
            fprintf(stderr, "Error closing database: %s\n", sqlite3_errmsg(db));
          }

          return NULL;
        }

        char *title;
        char *subtitle;
        char *body;
        parse_notification_details((const UInt8 *)plist_data, plist_data_len,
                                   &title, &subtitle, &body);

        // Queue to dynamic island
        struct islandItem *newNotificationItem =
            (struct islandItem *)malloc(sizeof(struct islandItem));

        snprintf(newNotificationItem->identifier, 32, "notifications");
        snprintf(newNotificationItem->args, 512, "%s|%s|%s|%s", title, subtitle,
                 body, app);

        lastNotifCount = notifCount;

        sqlite3_finalize(stmt);

        // Close the database
        rc = sqlite3_close(db);
        if (rc != SQLITE_OK) {
          fprintf(stderr, "Error closing database: %s\n", sqlite3_errmsg(db));
        }

        return newNotificationItem;
      }
    }
    lastNotifCount = notifCount;
  }

  sqlite3_finalize(stmt);

  // Close the database
  rc = sqlite3_close(db);
  if (rc != SQLITE_OK) {
    fprintf(stderr, "Error closing database: %s\n", sqlite3_errmsg(db));
  }
  return NULL;
}
