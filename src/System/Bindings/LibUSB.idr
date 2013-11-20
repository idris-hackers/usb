module System.Bindings.LibUSB

%lib C "usb-1.0"
%include C "libusb-1.0/libusb.h"

%include C "idris_usb.h"
%link C "idris_usb.o"

data Context = MkContext Ptr

libusb_init : IO (Maybe Context)
libusb_init = do
    res <- mkForeign (FFun "idris_libusb_init" [] FPtr)
    is_null <- nullPtr res
    return $ if is_null then Nothing else Just (MkContext res)

libusb_exit : Context -> IO ()
libusb_exit (MkContext p) = mkForeign (FFun "libusb_exit" [FPtr] FUnit) p

