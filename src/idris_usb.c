#include <stdlib.h>
#include <stdio.h>
#include <libusb-1.0/libusb.h>

#include <idris_rts.h> 

#include "idris_usb.h"


char *string_from_buffer(int len, void *buffer)
{
    return (char *)buffer;
}

uint8_t idris_libusb_peek(void *buffer, int i)
{
    return ((uint8_t *)(buffer))[i];
}

void idris_libusb_poke(void *buffer, int i, uint8_t b)
{
    ((uint8_t *)(buffer))[i] = b;
}

int idris_bits_to_int(uint8_t b)
{
   return (int)b;
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

    if(idris_libusb_errno) {
        return NULL;
    } else {
        return handle;
    }
}

int idris_libusb_get_configuration(libusb_device_handle *h)
{
    int c;

    idris_libusb_errno = libusb_get_configuration(h, &c);

    return c;
}

int idris_libusb_bulk_transfer(struct libusb_device_handle *dev_handle, unsigned char endpoint, unsigned char *data, int length, unsigned int timeout)
{
    int transferred;

    idris_libusb_errno = libusb_bulk_transfer(dev_handle, endpoint, data, length, &transferred, timeout);

    if(idris_libusb_errno) {
        return idris_libusb_errno;
    } else {
        return transferred;
    }
}

int idris_libusb_interrupt_transfer(struct libusb_device_handle *dev_handle, unsigned char endpoint, unsigned char *data, int length, unsigned int timeout)
{
    int transferred;

    idris_libusb_errno = libusb_interrupt_transfer(dev_handle, endpoint, data, length, &transferred, timeout);

    if(idris_libusb_errno) {
        return idris_libusb_errno;
    } else {
        return transferred;
    }

}


/*
void idris_usb_exit(void)
*/


