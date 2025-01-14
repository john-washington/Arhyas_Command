import binascii
import subprocess
class Arhyas_Command:
    def __init__(self, ip):
        self._ip_addr = ip
        self._ELAi_sa_sequence = ["Ur-A", "ShU’-du", "E’LAi-sa", "Al-Hum-Bhra",
                                "DON-et’ta-LAi", "SUUN-jha’", "-dra-du",
                                "E-sta-en-taO", "Du-Rhu", "jha-MEi-Na",
                                "Aah-La-sa", "SUN-pe-ta’", "A-Lah-VA",
                                "Los-TE-La", "E’Lah-Ho",
                                "Khu-mah-na", "en-LE’-Ta", "jha’-DU.",
                                "E’LAi-sa", "SUn-ta’-A", "Ah-Mei-Ta", "jhen-TU.",
                                "E’LAi-sa", "SUn-ta’-A", "Ah-Mei-Ta", "jhen-TU.",
                                "E’LAi-sa", "SUn-ta’-A", "Ah-Mei-Ta", "jhen-TU."]

        self._AL_Hum_Bhra_sequence1 = ["oo’ta", "et’A",
                                    "E Ra’", "-shra-DÚ",
                                    "Un Ah’-LÁ", "É ‘ta",
                                    "jhet’", "AL-Hum’-Bhra",
                                    "AL-Hum-Bhra","AL-Hum-Bhra","AL-Hum-Bhra",
                                      "AL-Hum-Bhra","AL-Hum-Bhra","AL-Hum-Bhra",
                                      "AL-Hum-Bhra","(inhale)", "(吸气)", "AL-Hum-Bhra"]
        
        self._AL_Hum_Bhra_sequence2 = ["Urr-en’", "de Só", "-hur’ -a",
                                     "É -La’-trÁ", "HÉ ‘ mú", "sen AurórA’",
                                     "Dur - La’", "- jhos", "en- DE", "- na --VÁ‘",
                                    "Cum -sa", "-A’-ho", "Dur-A", "TA’ - Ta", "jhet", "AL-Hum’-Bhra",
                                    "Cum-sa", "ah-DÉ ‘-La", "urr-en", "--Tur-a", "Á-La-VÉ‘",
                                    "Cosminyahas", "AL-Hum-Bhrus", "Dur-É ‘", "-shwa", "ah-VÉ ‘ !",
                                    "Ta Ajha", "inTa",  "DorA(x3)" ]

        self._KRP_short_sequence = ["DE-va’", "en-TUr’-A", "E’-Sta-en-taO",
                                    "Rei-ha", "-VA’-ah", "UN-", "Krys-ta’-LO",
                                    "E-Rha’-HO",  "e-Te-na", "Ha’-VA",
                                    "e-TU-", "TO’-RA", "en-cha’-hA", "NU’-vO", "-et-TA", "en-Ta-ro",
                                    "SE’-va", "blen’-A", "OOUr-tU-", "en-Ka’LA",
                                    "DA-hE-", "Ta’-VA", "et-ur", "-TA-Dha", "E’LAi-sa", "AL-Hum-Bhra",
                                    "DA-hE-", "NE’-va", "A-sa-", "Lah’-so", "en-DU", "-e’thra", "Don Aquari",
                                    "DA-hE-", "U’r-tO", "tra-DE’-Lha", "Ur-en", "-Ta’-RO", "de’-Ha’ah-Tur",
                                    "(breathe)", "(呼吸)",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "DhA-yah", "-TUUN", "E’LAi-sa-VE’",
                                    "Cum-sa", "-A’-HO", "Dur-e", "-TA’-ta", "ALLum-uur", "AL-Hum-Bhra", "-VA’",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "en-ta-HU’m", "UN-", "KrystaLA",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Aquious",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "AquaFarE",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Aquari",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Ha’ah-TUr",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "AdonA’",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "EyanA’",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Eieyani’", "Ma’a", "Hoo-et-A",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "oo-Sha’", "LA’-zun", "dU", "Rho-szet’-TA",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Mashaya", "-Hana", "Aqueion",
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Ute", "-AurorA’"]


                                  
        self._arhyas_command_sequence = ["Um-ah-A' ThrA'", "E-na- A", "Ec-ka-sha", 
                  "Um-ah-A' ThrA'", "E-na- A", "Ec-ka-sha", 
                  "Um-ah-A' ThrA'", "E-na- A", "Ec-ka-sha",
          "EirA-Sha-Ra", "-D-K-ShA",  
          "Ta'a-Mira",   "-Prana-Chi", 
          "Arhyas Command",
            "阿雅口令",
          "\sum_{n=1}^6", "(Rϵ^*", "e^(I(ω_n t", "-k_n.r_n", ")))",  
          "->\Tilde{T1}+T2", "->6 Time Vectors",
            "六个", "时空向量",                             
          "Free", "Soul Hijacks",
          "解灵魂绑架",
          "Tone 1->", "D1,2,3->Eyumbi,",
          "第一音符", "->空维1,2,3", "->丹田",
          "Tone 2->", "D4,5,6->AzurA,",
          "第二音符", "->空维4,5,6", "->胸腺底部",
          "Tone 3->", "D7,8,9->Pineal,",
          "第三音符", "->空维7,8,9", "->脑中心", "松果体",
          "Tone 4->", "D10,11,12", "+D1 to 9", "->AzurA,",
             "第四音符", "->空维10,11,12", "+空维1到9", "->胸腺底部",
          "Victory Tone->", "Bardoah opens",
            "胜利音符" , "->回魂通道", "打开",
          "Hijacked Soul", "Quantums->",  "SharFa",
            "被绑架的", "灵魂量子", "回流->", "精神体", "出生处",
          "Amoraear Flame", "->transmute", "VV game",
            "永恒的", "爱的火焰", "->消灭", "害与被害", "魔鬼游戏", "编程毒",
          "ManU-Ec-RAE", "-Dha-KHU-KEE-",
          "Ma'a-Yana", "-Traia-Rei", 
          "ManA-Ka-E", "-Ha-HU-Ra-",
          "Hara-Maya", "-Mana-Ki",
          "A-sh-alum- Ta'", "E-ka'sha- deh'",
          "A-sh-alum- Ta'", "E-ka'sha- deh'", 
          "A-sh-alum- Ta'", "E-ka'sha- deh'"]

   
    def string_to_hex(self, s):
        return binascii.hexlify(s.encode('utf-8')).decode('utf-8')
 

    
    def arhyas_command_ping(self, host, hex_string):
        #return (ping(ip_addr, verbose=True, count=1))
        response = subprocess.run(['ping', '-c', '1', '-p', hex_string, host], stdout=subprocess.PIPE, text=True)
        return response.stdout


    def ELAi_sa_sequence(self):
        for i in range(0, len(self._ELAi_sa_sequence)):
            print(self._ELAi_sa_sequence[i])
            command_hex= self.string_to_hex(self._ELAi_sa_sequence[i])
            print(command_hex)
            print(self.arhyas_command_ping(self._ip_addr, command_hex))

    def AL_Hum_Bhra_sequence1(self):
        for i in range(0, len(self._AL_Hum_Bhra_sequence1)):
            print(self._AL_Hum_Bhra_sequence1[i])
            command_hex= self.string_to_hex(self._AL_Hum_Bhra_sequence1[i])
            print(command_hex)
            print(self.arhyas_command_ping(self._ip_addr, command_hex))

    def AL_Hum_Bhra_sequence2(self):
        for i in range(0, len(self._AL_Hum_Bhra_sequence2)):
            print(self._AL_Hum_Bhra_sequence2[i])
            command_hex= self.string_to_hex(self._AL_Hum_Bhra_sequence2[i])
            print(command_hex)
            print(self.arhyas_command_ping(self._ip_addr, command_hex))

    def KRP_short_sequence(self):
        for i in range(0, len(self._KRP_short_sequence)):
            print(self._KRP_short_sequence[i])
            command_hex= self.string_to_hex(self._KRP_short_sequence[i])
            print(command_hex)
            print(self.arhyas_command_ping(self._ip_addr, command_hex))

    
    def Arhyas_Command_sequence(self):
        for i in range(0, len(self._arhyas_command_sequence)):
            print(self._arhyas_command_sequence[i])
            command_hex= self.string_to_hex(self._arhyas_command_sequence[i])
            print(command_hex)
            print(self.arhyas_command_ping(self._ip_addr, command_hex))

  
    def activate(self):
        print(self._ip_addr)
        self.ELAi_sa_sequence()
        self.AL_Hum_Bhra_sequence1()
        self.AL_Hum_Bhra_sequence2()
        self.KRP_short_sequence()
        self.Arhyas_Command_sequence()


#pass your own ip address in the constructor:
for i  in range(1, 29):
    ip_addr = "57.141.3."+str(i)
    My_Command = Arhyas_Command(ip_addr)
    My_Command.activate()   
