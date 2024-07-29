-- Versiyon 1.0.1
    -- Temel yapi olusturuldu.

-- Bu yazilim temel olarak 2 farkli adresten okuma yapan ancak tek bir adrese yazma yapabilen bir
-- Distributed Ram infer etmek amaciyla yazilmisit.
-- Tasarim Zybo Z7-10 uzerinde sentezlenmis olup genel olarak platform
-- farketmeksizin ayni gorevi icra etmesi beklenmektedir.
-- Implemente edildiginde LUT RAM yapisi kullanmasi beklenmektedir. RAMD32

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity dual_port_distributed_ram is
generic
(
    WORD_BIT_SAYISI     : integer := 8 ;    -- Bir word de kac bit olacagidir.
    WORD_ELEMAN_SAYISI  : integer := 32     -- Kac adet word tanimlanacagidir.
);
port
(
    -- Inputlar
    i_clk_bit           : in  std_logic;
    i_we_bit            : in  std_logic;
    i_yazma_adresi_ig   : in  integer range 0 to WORD_ELEMAN_SAYISI - 1;
    i_okuma_adresi_ig   : in  integer range 0 to WORD_ELEMAN_SAYISI - 1;
    i_yazilacak_veri_vg : in  std_logic_vector (WORD_BIT_SAYISI - 1 downto 0);

    -- Outputlar
    o_yazilan_adres_vg  : out std_logic_vector (WORD_BIT_SAYISI - 1 downto 0);
    o_okunan_adres_vg   : out std_logic_vector (WORD_BIT_SAYISI - 1 downto 0)
);
end dual_port_distributed_ram;

architecture behavioral of dual_port_distributed_ram is
    
    type RAM_T is array (WORD_ELEMAN_SAYISI - 1 downto 0) of std_logic_vector(WORD_BIT_SAYISI - 1 downto 0);
    signal ram_at   : ram_t;

begin

    process(i_clk_bit)
    begin

        if rising_edge(i_clk_bit) then
            if ('1' = i_we_bit) then
                ram_at(i_yazma_adresi_ig)   <= i_yazilacak_veri_vg;

            end if; -- if ('1' = i_we_bit) then
        end if; -- if rising_edge(i_clk_bit) then

    end process;

    o_yazilan_adres_vg  <= ram_at(i_yazma_adresi_ig);
    o_okunan_adres_vg   <= ram_at(i_okuma_adresi_ig);

end behavioral;
