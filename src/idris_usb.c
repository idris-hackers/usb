#include <stdlib.h>
#include <stdio.h>
#include <libusb-1.0/libusb.h>

#include <idris_rts.h> 

#include "idris_usb.h"


char *string_from_buffer(int len, void *buffer)
{
    return (char *)buffer;
}

/*
 * XXX obviously not thread safe
 */
int idris_libusb_errno;

int idris_libusb_get_errno(void)
{
    return idris_libusb_errno;
}

void *idris_libusb_init(void)
{
    libusb_context *ctx;

    idris_libusb_errno = libusb_init(&ctx);

    return ctx; 
}

void *idris_libusb_get_device_list(libusb_context *ctx)
{
    idris_libusb_device_list *list;

    list = calloc(1, sizeof(idris_libusb_device_list));

    if(list) {
        list->length = libusb_get_device_list(ctx, &list->list);
    }

    return list;
}

int idris_libusb_get_device_list_length(idris_libusb_device_list *list)
{
    if(list) {
        return list->length;
    } else {
        return -1;
    }
}

libusb_device *idris_libusb_get_device_from_list(idris_libusb_device_list *list, int index)
{
    if(list) { 
        if((index >= 0) && (index < list->length)) {
            return list->list[index];
        }
    } else {
        return NULL;
    }
}

void idris_libusb_free_device_list(idris_libusb_device_list *list, int unref)
{
    if(list) {
        libusb_free_device_list(list->list, unref);
    }
}

libusb_device_handle *idris_libusb_open(libusb_device *dev)
{
    libusb_device_handle *handle;

    idris_libusb_errno = libusb_open(dev, &handle);

    return handle;
}

int idris_libusb_get_configuration(libusb_device_handle *h)
{
    int c;

    idris_libusb_errno = libusb_get_configuration(h, &c);

    return c;
}


/*
void idris_usb_exit(void)
*/


