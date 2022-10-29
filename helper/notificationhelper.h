#include "sqlite3.h"
#include "stdio.h"
#include "stdlib.h"
#include <string.h>

static const char DBPATH_CMD[256] = {
    "lsof -p $(ps aux | grep -m1 usernoted | awk '{ print $2 }')| awk '{ print "
    "$NF }' | grep 'db2/db$'"};
char DBPATH[256];

struct notificationHelper {
  char command[512];
};

sqlite3 *db;

static inline void
database_init(struct notificationHelper *notificationHelper) {
  // get notification database location
  FILE *output;
  output = popen(DBPATH_CMD, "r");
  if (!output) {
    return;
  }
  fgets(DBPATH, sizeof(DBPATH), output);

  if (sqlite3_open(DBPATH, &db)) {
  }
}

static inline void
check_notifications(struct notificationHelper *notificationHelper) {}
