#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_QUEUE_SIZE 16

struct dynamicIsland {
  char command[256];
};

struct islandItem {
  char identifier[32];
  char args[256];
};

struct islandItemNode {
  struct islandItem *data;
  struct islandItemNode *nextNode;
};

struct islandItemNode *head = NULL;
struct islandItemNode *current = NULL;
char *currentDisplaying;
int queueCount = 0;
int isDisplaying = 0;

static inline void dynamic_island_init(struct dynamicIsland *dynamic_island) {
  snprintf(dynamic_island->command, 256, "");
}

static inline void pop_head() {
  // Redirect head to the second item
  struct islandItemNode *nextNode = NULL;
  nextNode = head->nextNode;

  free(head);

  head = nextNode;
  if (head == NULL) {
    current = NULL;
  }
  queueCount--;
}

static inline void sendCommand(struct dynamicIsland *dynamic_island,
                               int overrideSetting) {
  snprintf(dynamic_island->command, 256,
           "--trigger di_helper_listener_event IDENTIFIER=\"%s\" OVERRIDE=%d "
           "ARGS=\"%s\"",
           head->data->identifier, overrideSetting, head->data->args);
  currentDisplaying = head->data->identifier;
  isDisplaying = 1;
}

static inline int display(struct dynamicIsland *dynamic_island) {
  // Apply command
  if (head == NULL) {
    snprintf(dynamic_island->command, 256, "");
    memset(currentDisplaying, 0, 32);
    return 1;
  }

  if (queueCount > 1) {
    if (strcmp(currentDisplaying, head->nextNode->data->identifier) == 0) {
      pop_head();
      sendCommand(dynamic_island, 1);
      return 1;
    }
    if (isDisplaying == 0) {
      sendCommand(dynamic_island, 0);
      return 1;
    }
  } else if (queueCount == 1) {
    sendCommand(dynamic_island, 0);
    return 1;
  }

  return 0;
}

void removeOverride(char* checkIdentifier) {
  struct islandItemNode *temp = head->nextNode;
  if (temp == NULL) {
    return;
  }

  // Go through linked list
  while (temp != NULL) {
    struct islandItemNode *nextItem = temp->nextNode;

    if (strcmp(checkIdentifier, temp->data->identifier) == 0) {
      // Found override
      free(temp);
    }

    // Skip to next node
    temp = nextItem;
  }
}

static inline int queue_island(struct dynamicIsland *dynamic_island,
                               struct islandItem *itemToQueue) {
  // Create a new node and attach to the latest node
  struct islandItemNode *newNode =
      (struct islandItemNode *)malloc(sizeof(struct islandItemNode));
  newNode->data = itemToQueue;

  // TODO: Remove override
  // removeOverride(newNode->data->identifier);

  if (currentDisplaying != NULL) {
    if (strcmp(currentDisplaying, newNode->data->identifier) == 0) {
      // Redirect the node
      newNode->nextNode = head->nextNode;

      // Insert right after head
      head->nextNode = newNode;
    } else {
      if (current != NULL) {
        current->nextNode = newNode;
      }
    }
  }
  current = newNode;

  if (head == NULL) {
    head = current;
  }

  queueCount++;

  return display(dynamic_island);
}
