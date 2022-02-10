# qr
## usage
### command line demo
``` bash
qr 'hello world'


qr 'hello world' --output a.png
```

### code demo

``` python
import qrcode
qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
)
qr.add_data('Some data')
qr.make(fit=True)

img = qr.make_image(fill_color="black", back_color="white")
```

## help
```
Usage: qr - Convert stdin (or the first argument) to a QR Code.

When stdout is a tty the QR Code is printed to the terminal and when stdout is
a pipe to a file an image is written. The default image format is PNG.

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --factory=FACTORY     Full python path to the image factory class to create
                        the image with. You can use the following shortcuts to
                        the built-in image factory classes: pil, pymaging,
                        svg, svg-fragment, svg-path.
  --optimize=OPTIMIZE   Optimize the data by looking for chunks of at least
                        this many characters that could use a more efficient
                        encoding method. Use 0 to turn off chunk optimization.
  --error-correction=ERROR_CORRECTION
                        The error correction level to use. Choices are L (7%),
                        M (15%, default), Q (25%), and H (30%).
  --ascii               Print as ascii even if stdout is piped.
  --output=OUTPUT       The output file. If not specified, the image is sent
                        to the standard output.

```


