#ifndef __IDRIS_USB
#define __IDRIS_USB

#include <stdio.h>
#include <libusb-1.0/libusb.h>

char *string_from_buffer(int len, void *);

typedef struct idris_libusb_device_list {
    ssize_t length;
    libusb_device **list;
} idris_libusb_device_list;

extern int idris_libusb_errno;
void *idris_libusb_init(void);

int idris_libusb_geterrno(void);

void *idris_libusb_init(void);
void *idris_libusb_get_device_list(libusb_context *ctx);
int idris_libusb_get_device_list_length(idris_libusb_device_list *list);
libusb_device *idris_libusb_get_device_from_list(idris_libusb_device_list *list, int index);
void idris_libusb_free_device_list(idris_libusb_device_list *list, int unref);
libusb_device_handle *idris_libusb_open(libusb_device *dev);
int idris_libusb_get_configuration(libusb_device_handle *h);

#endif
