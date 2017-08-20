--
-- A simulation model of VIC20 hardware
-- Copyright (c) MikeJ - March 2003
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- You are responsible for any legal issues arising from your use of this code.
--
-- The latest version of this file can be found at: www.fpgaarcade.com
--
-- Email vic20@fpgaarcade.com
--
--
-- Revision list
--
-- version 001 initial release

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.Vcomponents.all;

entity VIC20_BLKRAMS is
  port (
    V_ADDR : in  std_logic_vector(12 downto 0);
    DIN    : in  std_logic_vector(7 downto 0);
    DOUT   : out std_logic_vector(7 downto 0);
    V_RW_L : in  std_logic;
    CS_L   : in  std_logic;
    ENA    : in  std_logic;
    CLK    : in  std_logic
    );
end;

architecture RTL of VIC20_BLKRAMS is

  signal addr : std_logic_vector(12 downto 0);
  signal we   : std_logic;

begin
  addr <= V_ADDR;

  ram01 : RAMB16_S2
    port map (
      DO   => DOUT(1 downto 0),
      DI   => DIN(1 downto 0),
      ADDR => addr(12 downto 0),
      WE   => we,
      EN   => ENA,
      SSR  => '0',
      CLK  => CLK
      );
  ram23 : RAMB16_S2
    port map (
      DO   => DOUT(3 downto 2),
      DI   => DIN(3 downto 2),
      ADDR => addr(12 downto 0),
      WE   => we,
      EN   => ENA,
      SSR  => '0',
      CLK  => CLK
      );
  ram45 : RAMB16_S2
    port map (
      DO   => DOUT(5 downto 4),
      DI   => DIN(5 downto 4),
      ADDR => addr(12 downto 0),
      WE   => we,
      EN   => ENA,
      SSR  => '0',
      CLK  => CLK
      );
  ram67 : RAMB16_S2
    port map (
      DO   => DOUT(7 downto 6),
      DI   => DIN(7 downto 6),
      ADDR => addr(12 downto 0),
      WE   => we,
      EN   => ENA,
      SSR  => '0',
      CLK  => CLK
      );

  p_we : process(V_RW_L, CS_L)
  begin
    we <= (not CS_L) and (not V_RW_L);
  end process;

end architecture RTL;
