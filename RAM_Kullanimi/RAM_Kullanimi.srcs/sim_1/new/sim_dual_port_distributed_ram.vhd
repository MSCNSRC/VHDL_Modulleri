library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity sim_dual_port_distributed_ram is
end sim_dual_port_distributed_ram;

architecture behavioral of sim_dual_port_distributed_ram is

    constant PARAM_WORD_ELEMAN_SAYISI   : integer := 32;
    constant PARAM_WORD_BIT_SAYISI      : integer := 8;
    constant zaman                      : time := 20 ns;


    signal s_i_clk_bit           : std_logic;
    signal s_i_we_bit            : std_logic;
    signal s_i_yazma_adresi_ig   : integer range 2 to PARAM_WORD_ELEMAN_SAYISI - 1;
    signal s_i_okuma_adresi_ig   : integer range 2 to PARAM_WORD_ELEMAN_SAYISI - 1;
    signal s_i_yazilacak_veri_vg : std_logic_vector (PARAM_WORD_BIT_SAYISI - 1 downto 0);

    signal s_o_yazilan_adres_vg  : std_logic_vector (PARAM_WORD_BIT_SAYISI - 1 downto 0);
    signal s_o_okunan_adres_vg   : std_logic_vector (PARAM_WORD_BIT_SAYISI - 1 downto 0);


begin

RAM: entity work.dual_port_distributed_ram(behavioral)
generic map
(
    WORD_BIT_SAYISI     => PARAM_WORD_BIT_SAYISI    ,
    WORD_ELEMAN_SAYISI  => PARAM_WORD_ELEMAN_SAYISI
)
port map
(
    i_clk_bit           => s_i_clk_bit          ,
    i_we_bit            => s_i_we_bit           ,
    i_yazma_adresi_ig   => s_i_yazma_adresi_ig  ,
    i_okuma_adresi_ig   => s_i_okuma_adresi_ig  ,
    i_yazilacak_veri_vg => s_i_yazilacak_veri_vg,

    o_yazilan_adres_vg  => s_o_yazilan_adres_vg ,
    o_okunan_adres_vg   => s_o_okunan_adres_vg   
);


CLOCK_URETECI:  process
begin
    s_i_clk_bit <= '1'; wait for zaman/2;
    s_i_clk_bit <= '0'; wait for zaman/2;
end process;

TEST: process
variable v_sayac_i  : integer := 0;
begin
    s_i_we_bit <= '0'; s_i_yazma_adresi_ig <= 0; s_i_okuma_adresi_ig <= 0; s_i_yazilacak_veri_vg <= std_logic_vector(to_unsigned(200, PARAM_WORD_BIT_SAYISI));
    wait for zaman*2;
    s_i_we_bit <= '0'; s_i_yazma_adresi_ig <= 1; s_i_okuma_adresi_ig <= 2; s_i_yazilacak_veri_vg <= std_logic_vector(to_unsigned(201, PARAM_WORD_BIT_SAYISI));
    wait for zaman*2;

    s_i_we_bit <= '1'; s_i_yazma_adresi_ig <= 0; s_i_okuma_adresi_ig <= 4; s_i_yazilacak_veri_vg <= std_logic_vector(to_unsigned(45, PARAM_WORD_BIT_SAYISI));
    wait for zaman;

    s_i_we_bit <= '1'; s_i_yazma_adresi_ig <= 1; s_i_okuma_adresi_ig <= 0; s_i_yazilacak_veri_vg <= std_logic_vector(to_unsigned(46, PARAM_WORD_BIT_SAYISI));
    wait for zaman;

    s_i_we_bit <= '1'; s_i_yazma_adresi_ig <= PARAM_WORD_ELEMAN_SAYISI-1; s_i_okuma_adresi_ig <= 1; s_i_yazilacak_veri_vg <= std_logic_vector(to_unsigned(16, PARAM_WORD_BIT_SAYISI));
    wait for zaman;

end process;


end behavioral;
