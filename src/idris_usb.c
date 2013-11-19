#include <stdlib.h>
#include <libusb-1.0/libusb.h>


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
    int res;

    libusb_context *ctx;

    idris_libusb_errno = libusb_init(&ctx);
    
    return ctx; 
}

/*
void idris_usb_exit(void)
*/

