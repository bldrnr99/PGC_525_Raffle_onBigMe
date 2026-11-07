
ATTENTION: LanManager is Pc Software designed to work on a Rs485 network
           with devices like  MgReaders and MgActuators.
           See    http://www.3msystem.com/MicroGuard.htm
           for details.

           LanManager is default configured with a Test configuration
           network topology. When a customer decide to use and buy this
           product (Readers & Pc Software), he will receive a new
           "configuration database" with the parameters and layout to
           fit its particular Lan.



	Steps to install  Microguard LanManager:
	========================================

- To install a Microguard solution on a new PC it's
  necessary install Smartidea Hw & Sw first. See 
  Smartidea package for instructions about this.

- Once a Smartidea is installed and basic test (smcTest2.exe)
  work fine, it's necessary install a serial line converter
  from Rs232 To Rs485.
  It's better an external device with its own power supply;
  you can find many types in your local computer shop.
  It also must be configured for "Multidrop" network and Transmit
  only when "RTS" active. See your converter instructions manual 
  for more details.
  By default Microguard LanManager is configured to work on COM2.
  It is possible override this parameter in the LanConfig database,
  but only when user have enough experience with default config !

- Run the InstallMicroguard.exe and choose the destination folder
  you prefer. When finished it's not necessary reboot the system.

- At Login (possible also with Smartidea cards) the default user
  is Administrator with no password.

- Without devices (microguard Readers and Actuators) on the Lan,
  is not possible do full evaluation of the product, but the Pc
  software give you a good idea of what is possible do with microguard
  devices.
  With MgClient is also possible communicate your commands and receive
  events from MgLan Manager. See EventLog to check if your commands
  are processed.

for more info:  tech@3msystem.com

3 Emme System
www.3msystem.com
