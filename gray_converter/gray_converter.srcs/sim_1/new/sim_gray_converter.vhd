library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sim_gray_converter is
end sim_gray_converter;

architecture behavioral of sim_gray_converter is
    constant C_BIT_UZUNLUGU : integer := 8;

    signal s_i_giris_verisi_vg   : std_logic_vector(C_BIT_UZUNLUGU - 1 downto 0);
    signal s_gray_degeri_vg      : std_logic_vector(C_BIT_UZUNLUGU - 1 downto 0);
    signal s_o_cikis_verisi_vg   : std_logic_vector(C_BIT_UZUNLUGU - 1 downto 0);
    
begin

GRAY_2_BINARY   : entity work.gray_2_binary(behavioral)
generic map
(
    BIT_UZUNLUGU => C_BIT_UZUNLUGU
)
port map
(
    i_giris_verisi_vg   => s_i_giris_verisi_vg,
    o_cikis_verisi_vg   => s_gray_degeri_vg
);

BINARY_2_GRAY   : entity work.binary_2_gray(behavioral)
generic map
(
    BIT_UZUNLUGU => C_BIT_UZUNLUGU
)
port map
(
    i_giris_verisi_vg   => s_gray_degeri_vg   ,
    o_cikis_verisi_vg   => s_o_cikis_verisi_vg
);


process
begin
    
    for for_sayac in 0 to 255
    loop
        s_i_giris_verisi_vg <= std_logic_vector(to_unsigned(for_sayac, C_BIT_UZUNLUGU));
        wait for 100 ns;

        assert (s_i_giris_verisi_vg = s_o_cikis_verisi_vg)
        report "Yanlis"
        severity failure;
    end loop;

    

assert false
report "SIMULASYON BITTI"
severity failure;
end process;

end behavioral;