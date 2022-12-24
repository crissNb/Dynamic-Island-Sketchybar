#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_QUEUE_SIZE 16

struct dynamicIsland {
  char command[512];
};

struct islandItem {
  char identifier[32];
  char args[512];
};

struct islandItemNode {
  struct islandItem *data;
  struct islandItemNode *nextNode;
};

struct islandItemNode *head = NULL;
struct islandItemNode *current = NULL;
char currentDisplaying[32];
int isDisplaying = 0;

static inline void dynamic_island_init(struct dynamicIsland *dynamic_island) {
  snprintf(dynamic_island->command, 512, "");
}

static inline void pop_head() {
  if (head == NULL) {
    return;
  }

  // Redirect head to the second item
  struct islandItemNode *nextNode = NULL;
  nextNode = head->nextNode;

  free(head);

  head = nextNode;
  if (head == NULL) {
    current = NULL;
  }
}

static inline void sendCommand(struct dynamicIsland *dynamic_island,
                               int overrideSetting) {
  if (head == NULL) {
    return;
  }
  snprintf(dynamic_island->command, 512,
           "--trigger di_helper_listener_event IDENTIFIER=\"%s\" OVERRIDE=%d "
           "ARGS=\"%s\"",
           head->data->identifier, overrideSetting, head->data->args);
  strcpy(currentDisplaying, head->data->identifier);
  isDisplaying = 1;
}

static inline int display(struct dynamicIsland *dynamic_island) {
  if (head == NULL) {
    // Do not apply any command
    return 0;
  }

  if (isDisplaying == 0) {
    sendCommand(dynamic_island, 0);
    return 1;
  } else {
    if (head->nextNode != NULL) {
      if (strcmp(currentDisplaying, head->nextNode->data->identifier) == 0) {
        pop_head();
        sendCommand(dynamic_island, 1);
        return 1;
      }
    }
  }

  return 0;
}

static inline int queue_island(struct dynamicIsland *dynamic_island,
                               struct islandItem *itemToQueue) {
  // Create a new node and attach to the latest node
  struct islandItemNode *newNode =
      (struct islandItemNode *)malloc(sizeof(struct islandItemNode));
  newNode->data = itemToQueue;

  if (currentDisplaying[0] != 0) {
    if (strcmp(currentDisplaying, newNode->data->identifier) == 0) {
      // Redirect the node
      newNode->nextNode = head->nextNode;

      // Insert right after head
      head->nextNode = newNode;
    } else {
      if (current != NULL) {
        struct islandItemNode *temp = head->nextNode;

        while (temp != NULL) {
          if (strcmp(temp->data->identifier, newNode->data->identifier) == 0) {
            temp->data = newNode->data;
            free(newNode);
            return 0;
          }
          temp = temp->nextNode;
        }
        current->nextNode = newNode;
      }
    }
  }
  current = newNode;

  if (head == NULL) {
    head = current;
  }

  return display(dynamic_island);
}
