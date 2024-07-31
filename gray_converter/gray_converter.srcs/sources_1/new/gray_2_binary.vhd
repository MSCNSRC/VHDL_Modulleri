-- Versiyon 1.0.1
    -- Temel yapi olusturuldu.

-- Bu yazilim temel olarak giristeki gray kod degerinin binary karsiligini asenkron 
-- olarak hesaplayarak cikisa vermektedir. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray_2_binary is
generic
(
    BIT_UZUNLUGU  : integer := 8
);
port 
( 
    i_giris_verisi_vg   : in  std_logic_vector(BIT_UZUNLUGU - 1 downto 0);
    o_cikis_verisi_vg   : out std_logic_vector(BIT_UZUNLUGU - 1 downto 0)
);
end gray_2_binary;

architecture behavioral of gray_2_binary is

begin

    process(i_giris_verisi_vg)
        variable var_gray_degeri_vg : std_logic_vector(BIT_UZUNLUGU - 1 downto 0);

    begin

        var_gray_degeri_vg(BIT_UZUNLUGU - 1) := i_giris_verisi_vg(BIT_UZUNLUGU - 1);

        for for_sayac in BIT_UZUNLUGU - 2 downto 0
        loop
            var_gray_degeri_vg(for_sayac) := i_giris_verisi_vg(for_sayac + 1) xor i_giris_verisi_vg(for_sayac);
        end loop;

        o_cikis_verisi_vg <= var_gray_degeri_vg;

    end process;

end behavioral;
