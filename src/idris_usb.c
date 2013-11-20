#include <stdlib.h>
#include <libusb-1.0/libusb.h>

#include <idris_rts.h> 

/*
 * XXX obviously not thread safe
 */
int idris_libusb_errno;

int idris_libusb_geterrno(void)
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
    libusb_device **list;
    
    /* Abuse */
    idris_libusb_errno = libusb_get_device_list(ctx, &list);

    return list;
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


