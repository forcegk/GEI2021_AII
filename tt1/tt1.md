# TT1 - AII

## Solaris 10
### Instalación Interactiva de VBox Additions
```bash
#!/bin/bash

set -e

echo "Inserta el CD de VirtualBox Guest Additions, espera a que se automonte, y pulsa <ENTER> para continuar..."
read
pushd /cdrom/vboxadditions_* > /dev/null

pkgadd -d ./VBoxSolarisAdditions.pkg

popd > /dev/null

echo "Recuerda reiniciar o reloguear para aplicar las Guest Additions! (<ENTER> para continuar instalando)"
read

mkdir -p /export/home/pc/pkg
pushd /export/home/pc/pkg > /dev/null

# Descargamos los paquetes
/usr/sfw/bin/wget "http://www.dc.fi.udc.es/~afyanez/Docencia/2021/Grado/files/FSWpart.tar.gz" --no-check-certificate & 
/usr/sfw/bin/wget "http://www.dc.fi.udc.es/~afyanez/Docencia/2021/Grado/files/FSWfsmisc.tar.gz" --no-check-certificate  & 
/usr/sfw/bin/wget "https://get.geo.opera.com/ftp/pub/opera/unix/solaris/1011/en/intel/opera-10.11.gcc4-static-qt3.pkg.gz" --no-check-certificate &
wait

gunzip FSWpart.tar.gz &
gunzip FSWfsmisc.tar.gz &
gunzip opera-10.11.gcc4-static-qt3.pkg.gz &
wait

tar xvf FSWpart.tar &
tar xvf FSWfsmisc.tar &
wait

pkgadd -d . FSWpart
pkgadd -d . FSWfsmisc
pkgadd -d ./opera-10.11.gcc4-static-qt3.pkg

popd > /dev/null
echo "Comprueba que Opera funciona (/usr/local/bin/opera) y listo!"
```