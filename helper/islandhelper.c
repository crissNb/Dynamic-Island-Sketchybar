#include "dynamicisland.h"
#include "sketchybar.h"
#include <stdio.h>

struct dynamicIsland g_dynamic_island;

void handler(env env) {
  // Environment variables passed from sketchybar can be accessed as seen below
  char *name = env_get_value_for_key(env, "NAME");
  char *sender = env_get_value_for_key(env, "SENDER");
  char *id = env_get_value_for_key(env, "INFO");
  char *args = env_get_value_for_key(env, "ISLAND_ARGS");

  if (strcmp(sender, "dynamic_island_queue") == 0) {
    // Create new queuable item
    struct islandItem *newItem =
        (struct islandItem *)malloc(sizeof(struct islandItem));
    sprintf(newItem->identifier, "%s", id);
    sprintf(newItem->args, "%s", args);

    // Get item from queue and apply to dynamic island
    if (queue_island(&g_dynamic_island, newItem) == 1) {
      sketchybar(g_dynamic_island.command);
    }
  } else if (strcmp(sender, "dynamic_island_request") == 0) {
    // Request to deliver new island
    isDisplaying = 0;
    pop_head();
    if (display(&g_dynamic_island) == 1) {
      sketchybar(g_dynamic_island.command);
    }
  }
}

int main(int argc, char **argv) {
  dynamic_island_init(&g_dynamic_island);

  if (argc < 2) {
    printf("Usage: provider \"<bootstrap name>\"\n");
    exit(1);
  }

  event_server_begin(handler, argv[1]);
  return 0;
}
