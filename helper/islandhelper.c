#include "notificationhelper.h"
#include "sketchybar.h"
#include <stdio.h>

struct dynamicIsland g_dynamic_island;
struct notificationHelper g_notification_helper;

void handler(env env) {
  // Environment variables passed from sketchybar can be accessed as seen below
  char *name = env_get_value_for_key(env, "NAME");
  char *sender = env_get_value_for_key(env, "SENDER");
  char *id = env_get_value_for_key(env, "INFO");
  char *args = env_get_value_for_key(env, "ISLAND_ARGS");

  if (strcmp(sender, "dynamic_island_request") == 0) {
    // Request to deliver new island
    isDisplaying = 0;

    // clear current displaying
    memset(currentDisplaying, 0, 32);
    snprintf(g_dynamic_island.command, 512, "");

    pop_head();

    if (display(&g_dynamic_island) == 1) {
      sketchybar(g_dynamic_island.command);
    }
  } else if (strcmp(sender, "dynamic_island_queue") == 0) {
    // Check data is not null
    if (args[0] == '\0' || id[0] == '\0') {
      return;
    }

    // Create new queuable item
    struct islandItem *newItem =
        (struct islandItem *)malloc(sizeof(struct islandItem));
    sprintf(newItem->identifier, "%s", id);
    sprintf(newItem->args, "%s", args);

    // Get item from queue and apply to dynamic island
    if (queue_island(&g_dynamic_island, newItem) == 1) {
      sketchybar(g_dynamic_island.command);
    }
  } else if ((strcmp(sender, "routine") == 0) ||
             (strcmp(sender, "forced") == 0)) {
    // Check notifications

    // check environment variable exists to prevent seg fault
    if (getenv("P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED") == NULL) {
      return;
    }

    if (*getenv("P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED") == (char)'1') {
      struct islandItem *notificationItem =
          check_notifications(&g_notification_helper);

      if (notificationItem != NULL) {
        // Queue notification item to display
        if (queue_island(&g_dynamic_island, notificationItem) == 1) {
          sketchybar(g_dynamic_island.command);
        }
      }
    }
  }
}

int main(int argc, char **argv) {
  if (argc < 2) {
    printf("Usage: provider \"<bootstrap name>\"\n");
    exit(1);
  }

  dynamic_island_init(&g_dynamic_island);

  if (getenv("P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED") == NULL &&
      *getenv("P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED") == (char)'1') {
    database_init(&g_notification_helper);
  }

  event_server_begin(handler, argv[1]);
  return 0;
}
