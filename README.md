## Docker Image with ESPTOOL & SSH
This Docker image is based on python:latest and includes:
 - SSH server
 - ESPTOOLS
 - SUDO

### Some usefull commands:

**Backup memory**

    esptool.py --port /dev/ttyUSB0 read_flash 0x00000 0x100000 fwbackup.bin

**Erase memory**

    esptool.py --port /dev/ttyUSB0 erase_flash

**Install Tasmota firmware ESP32**

    esptool.py --port /dev/ttyUSB0 write_flash 0x0 tasmota32.factory.bin

**Read MAC address**

    esptool.py --port /dev/ttyUSB0 read_mac
