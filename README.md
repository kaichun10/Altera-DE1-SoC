___

### Design and test state machine on FPGA
___

#### Project summary
___


Requirement
  - Hardware devices
    * Opal Kelly XEM6310 ( for ISE stimulaiton)
    + DE1-SoC (for testing VGA and GPIO camera)
  - Software
    * Xilinx ISE 14.7 Embedded edition
    + FrontPanel API
    * Quartus-lite-20.1.1
    
___


 Set-up design environment
  - Windows 10 Xilinx ISE installation
    * [Setup local directory](#Windows-10-Xilinx-ISE-installation)
    + [Obtain and add ISE licence](#Licensing-problem-with-ISE-Editions)
  - Ubuntu 20.04.2 Xilinx ISE installation
    * [Install ISE Driver](#Install-ISE-Driver:)
    + [Using IMPACT command](#For-IMPACT-instruction:)
  - (Optional) Configure and testing in NCLaunch using school server
    * [Compile in Cadence NCLaunch and simulating in SimVision](#Compiling-VHDL-in-Cadence-NCLaunch-and-simulating-in-SimVision)

___


CI/CD pipeline testing in GitLab 
  - [Install and setup specific GitLab runner](#Install-and-run-GitLab-runner)
  - [implement simple CI/CD test pipeline](#Install-and-run-GitLab-runner)


___


#### Windows 10 Xilinx ISE installation

___
#### Licensing problem with ISE Editions

`IMPORTANT`

ISE WebPack does not support LX150 (only up to LX75) and projects do not compile in WebPack. To solve this problem, choose `ISE Embedded edition` during the installation process.

![Licence_Table_For_LX150](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/LX150_Licence_Table.JPG)


ISE Embedded edition requires a licence to activate, follow the link when adding licence for the first time and choose ISE Embedded edition on the Product licensing page.
 
![ISE_Embedded_Licence](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/LX150_ISE_Licence.PNG)


___
#### Ubuntu 20.04.2 Xilinx ISE installation
___

#### Xilinx ISE setup:

1. Install Xilinx_ISE_DS_Lin_14.7_1015_1.tar

2. Extract using 
sudo tar -xvf Xilinx_ISE_DS_Lin_14.7_1015_1.tar

3. cd Xilinx_ISE_DS_Lin_14.7_1015_1

4. sudo ./xsetup

5. Add the following line in ~/.bashrc
source /opt/Xilinx/14.7/ISE_DS/settings64.sh

6. Restart Terminal

___

#### Install ISE Driver:

Run the following command

1. sudo /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/install_script/install_drivers/./install_drivers

2. cd /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/digilent/ 

3. sudo ./install_digilent.sh

4. sudo apt-get install gitk git-gui libusb-dev build-essential libc6-dev-i386 fxload libftdi-dev

5. cd /opt/Xilinx/14.7

6. sudo git clone git://git.zerfleddert.de/usb-driver

7. cd usb-driver

8. sudo make

9. ./setup_pcusb /opt/Xilinx/14.7/ISE_DS/ISE/

___

#### For IMPACT instruction:

Run the following command

1. export LD_PRELOAD=/opt/Xilinx/14.7/usb-driver/libusb-driver.so

___

#### System Generator with Matlab:

1. cd /opt/Xilinx/14.7/ISE_DS/ISE/sysgen/util

2. sudo vim sysgen

3. Replace #!/bin/sh with #!/bin/bash

___

#### Slowing the CLK frequency for human-readable output
___


`Method one:`

    Using a constant value and counting up until 2500000 to delay time

``` vhdl

    CONSTANT c_CNT_10HZ : NATURAL := 2500000;
    SIGNAL r_CNT_10HZ : NATURAL RANGE 0 TO c_CNT_10HZ;
    SIGNAL r_TOGGLE_10HZ : STD_LOGIC := '0';

    BEGIN

    p_10_HZ : PROCESS (top_clock) IS
     BEGIN
      IF rising_edge(top_clock) THEN
       IF r_CNT_10HZ = c_CNT_10HZ - 1 THEN -- because counter starts at 0
         r_TOGGLE_10HZ <= NOT r_TOGGLE_10HZ;
         r_CNT_10HZ <= 0;
       ELSE
         r_CNT_10HZ <= r_CNT_10HZ + 1;
       END IF;
     END IF;
    END PROCESS p_10_HZ;
```

___

`Method two:`

    Using the MSB of 24 bits signal bus
    
``` vhdl
    SIGNAL slow_clk : STD_LOGIC;
    SIGNAL clk_divider : STD_LOGIC_VECTOR(23 DOWNTO 0) := x"000000";

    BEGIN

    clk_division : PROCESS (clk, clk_divider)
    BEGIN
     IF (clk = '1' AND clk'event) THEN
      clk_divider <= clk_divider + 1;
     END IF;

      slow_clk <= clk_divider(23);
    END PROCESS;
```

___

#### VGA output
___

![vga_syn](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/vga_syn.png)
___

#### 24 bits VGA colour picker from hexadecimal value
[![IMAGE ALT TEXT HERE](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/605e8f5edde4e-fbutube-VGA-colour-picker.PNG)](https://www.youtube.com/watch?v=D_EPlZ3a8Pw&t=2s)

___

	Horizontal synchronous goes low between front porch and back porch
``` vhdl
    // Horizontal synchronus
	HSync : PROCESS (h_pos)
	BEGIN
		IF h_pos >= 920 THEN
			VGA_HS <= '0';
		ELSE
			VGA_HS <= '1';
		END IF;
	END PROCESS HSync;
```
___

	Vertical synchronous goes low between front porch and back porch
``` vhdl
    // Vertical synchronus
	VSync : PROCESS (v_pos)
	BEGIN
		IF v_pos >= 660 THEN
			VGA_VS <= '0';
		ELSE
			VGA_VS <= '1';
		END IF;
	END PROCESS VSync;
```

___

	Horizontal active area
``` vhdl
	HActive : PROCESS (h_pos)
	BEGIN
		IF (h_pos > 63 AND h_pos < 864) THEN
			h_active <= '1';
		ELSE
			h_active <= '0';
		END IF;
	END PROCESS HActive;
```
___

	Vertical active area
``` vhdl
	VActive : PROCESS (v_pos)
	BEGIN
		IF (v_pos > 22 AND v_pos < 623) THEN
			v_active <= '1';
		ELSE
			v_active <= '0';
		END IF;
	END PROCESS VActive;
```
___


#### ISim simulation in Xilinx ISE and testing on XEM6310 using FrontPanel Loader
[![IMAGE ALT TEXT HERE](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/605c8148bc993-fbutube-ISE.png)](https://www.youtube.com/watch?v=sqyJVjWYPRE)

___

#### Set up and configure in Quartus Lite
[![IMAGE ALT TEXT HERE](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/605c816516c03-fbutube-Quartus.png)](https://www.youtube.com/watch?v=6Hcd2ZrclaE&t=17s)

___

#### `(Opitional)`

#### Compiling VHDL in Cadence NCLaunch and simulating in SimVision
[![IMAGE ALT TEXT HERE](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/605c8581d7129-fbutube-Cadence-NCLaunch.png)](https://www.youtube.com/watch?v=sJV8FFTZp4o&t=204s)

___


#### GitLab specific runner and pipeline setup

___

#### Install and setup specific GitLab runner plus implement simple CI/CD test pipeline

[![IMAGE ALT TEXT HERE](https://raw.githubusercontent.com/kaichun10/Altera-DE1-SoC/main/img/605c846faa5f1-fbutube-GitLab-CI-CD-Pipeline.png)](https://www.youtube.com/watch?v=YLt1fnEq66U&t=225s)

___






#### Install and run GitLab runner

1. Create a folder named GitLab-Runner

2. Download .exe and rename to gitlab-runner.exe

3. Run an elevated command prompt (CMD Run as Administrator)

4. Register a runner
.\gitlab-runner.exe register

5. Install GitLab Runner
cd C:\GitLab-Runner
.\gitlab-runner.exe install
.\gitlab-runner.exe start

___

#### Run CI/CD pipeline
1. Create `.gitlab-ci.yml`

2. Write a simple test in `.yaml`

3. Git commit and push

4. Make changes and push again to test the pipeline

___
