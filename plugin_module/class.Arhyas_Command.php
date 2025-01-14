<?php
/**
 * Class for Arhyas Command.
 * Author: John S. Zhang Washington
 * 12/17/2024
 */

defined('ABSPATH') || exit; // Exit if accessed directly.

class Arhyas_Command
{
   public $_ipaddr; 
   public $_ELAi_sa_sequence;
   public $_AL_Hum_Bhra_sequence1; 
   public $_AL_Hum_Bhra_sequence2;
   public $_KRP_sequence;
   public $_Arhyas_Command_sequence;
   public $_KRP_Elemental_Command_sequence;

   public function __construct( $ip )
   {

	   $this->_ipaddr = $ip;

    $this->_ELAi_sa_sequence = array("Ur-A", "ShU’-du", "E’LAi-sa", "Al-Hum-Bhra",
                                "DON-et’ta-LAi", "SUUN-jha’", "-dra-du",
                                "E-sta-en-taO", "Du-Rhu", "jha-MEi-Na",
                                "Aah-La-sa", "SUN-pe-ta’", "A-Lah-VA",
                                "Los-TE-La", "E’Lah-Ho",
                                "Khu-mah-na", "en-LE’-Ta", "jha’-DU.",
                                "E’LAi-sa", "SUn-ta’-A", "Ah-Mei-Ta", "jhen-TU.",
                                "E’LAi-sa", "SUn-ta’-A", "Ah-Mei-Ta", "jhen-TU.",
                                "E’LAi-sa", "SUn-ta’-A", "Ah-Mei-Ta", "jhen-TU.");

    $this->_AL_Hum_Bhra_sequence1 = array("oo’ta", "et’A",
                                    "E Ra’", "-shra-DÚ",
                                    "Un Ah’-LÁ", "É ‘ta",
                                    "jhet’", "AL-Hum’-Bhra",
                                    "AL-Hum-Bhra","AL-Hum-Bhra","AL-Hum-Bhra",
                                      "AL-Hum-Bhra","AL-Hum-Bhra","AL-Hum-Bhra",
                                      "AL-Hum-Bhra","(inhale)", "(吸气)", "AL-Hum-Bhra");

    $this->_AL_Hum_Bhra_sequence2 = array("Urr-en’", "de Só", "-hur’ -a",
                                     "É -La’-trÁ", "HÉ ‘ mú", "sen AurórA’",
                                     "Dur - La’", "- jhos", "en- DE", "- na --VÁ‘",
                                    "Cum -sa", "-A’-ho", "Dur-A", "TA’ - Ta", "jhet", "AL-Hum’-Bhra",
                                    "Cum-sa", "ah-DÉ ‘-La", "urr-en", "--Tur-a", "Á-La-VÉ‘",
                                    "Cosminyahas", "AL-Hum-Bhrus", "Dur-É ‘", "-shwa", "ah-VÉ ‘ !",
                                    "Ta Ajha", "inTa",  "DorA", "repeat x3" );

    $this->_KRP_sequence = array("DE-va’", "en-TUr’-A", "E’-Sta-en-taO",
                                    "Rei-ha", "-VA’-ah", "UN-", "Krys-ta’-LO",
                                    "E-Rha’-HO",  "e-Te-na", "Ha’-VA",
                                    "e-TU-", "TO’-RA", "en-cha’-hA", "NU’-vO", "-et-TA", "en-Ta-ro",
                                    "SE’-va", "blen’-A", "OOUr-tU-", "en-Ka’LA",
                                    "DA-hE-", "Ta’-VA", "et-ur", "-TA-Dha", "E’LAi-sa", "AL-Hum-Bhra",
                                    "DA-hE-", "NE’-va", "A-sa-", "Lah’-so", "en-DU", "-e’thra", "Don Aquari",
                                    "DA-hE-", "U’r-tO", "tra-DE’-Lha", "Ur-en", "-Ta’-RO",
                                    "de’-", "Ha’ah-Tur",
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
                                    "Cum-sa", "-A’-HO", "DUr-e", "-TA’-ta", "Ute", "-AurorA’",
                                   "(Kristiac", "Councils", "of the Aurora", "-Guardians of", "the Spanner Gates",
                                   "跨度者", "星門的", "極光", "護衛者", "基督", "理事會)",
                                   "Bhendi-", "Aah-jha", "et-tu", "E’LAi-sa", "AL-Hum-Bhrus",
                                   "Bhendi-", "Dur’O-", "ah-MA’-Jha", "Ute-AurorA", "Aqueion",
                                    "(Urtha-", "AquafarE",  "Blue Dragons", "-Aquatic-bird", "-blue-humanid",
                                    "俄薩－", "啊跨發理", "“藍龍”", "－水棲－鳥", "－藍人類)",
                                    "Bhendi-", "Ha’-LA", "E-Sha-", "NU’-a", "Ute-AurorA",
                                    "Aqueion",
                                    "(Urtha-", "AquafarE", "Gold Dragons", "-Winged-lion", "-biped-humanid",
                                    "俄薩－", "啊跨發理", "“金龍”", "－翼獅－", "雙足－人類)",
                                    "Bhendi-", "Ra-MA’", "Ra-tha-", "jhen-tU", "Ute-AurorA",
                                    "Aqueion",
 "(Urtha-", "AquafarE", "Purple Dragons", "-Breatharian", "-white-humanid",
                                    "俄薩－", "啊跨發理", "“紫龍”", "－呼吸食－", "白－人類)",
                                    "(breathe)",
                                    "Bring forth now", "the", "Krystal River", "of Eternal", "1st Creation",
                                    "現在呈現", "永恆", "第1創造的", "聖水晶河流",
                                    "Bring forth now", "the", "Healing Waters", "of the", "Edon’s", "Umshaddhi",
                                    "現在呈現", "醫當世界的", "Umshaddhi的", "醫療聖水",
                                    "Bring forth now", "the Gentle", "Wind-song", "of the", "Sacred Yunasun",
                                    "現在呈現", "神聖Yunasun的", "溫和的", "風之歌",
                                    "(Central Sun of", "the Yunasai", "Inner Domain", "Seed-Atom", "yunasai",
                                    "的內界", "種原子的", "中央太陽)",
                                    "Bring forth here",  "the", "Radiant", "Starlight", "of the", "Eternally", "StarBorn.",
                                    "在此處", "呈現", "永恆星誕的", "明亮的星光",
                                    "Let the", "Krystal River", "flow unto", "my doorstep",
                                    "讓水晶河", "流到", "我的家門",
                                    "Let the", "Krystal River", "cleanse", "and", "heal my Soul",
                                    "讓水晶河水", "潔淨", "和治愈", "我的靈魂",
                                    "May the", "Krystal River", "Love-song", "All", "-embracing",
                                    "願水晶河", "那包羅萬象", "的愛歌",
                                    "Emerge now", "from my", "Krysted", "Krystal Core",
                                    "現在", "從我的", "基督", "聖化了的", "聖水晶", "核心中", "升起",
                                    "To softly", "call me HOME!",
                                    "輕輕地", "呼喚我回家",
                                    "(Repeat 3x)", "(重復3遍)",
                                    "DE-va’", "en-TUr’-A", "E’-Sta-en-taO",
                                    "Rei-ha-VA’-ah", "UN-", "Krys-ta’-LO",
                                    "(先古語...)",
                                    "(Repeat 3x)", "(重復3遍)",
                                    "Ashalum-Ta-", "Eckasha DUr",
                                    "(先古語)");

    $this->_Arhyas_Command_sequence = array("Um-ah-A' ThrA'", "E-na- A", "Ec-ka-sha",
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
          "Tone 1:","Tellura", "D1,2,3->Eyumbi,",
          "第一音符:", "Tellura", "空维1,2,3", "->丹田",
          "Tone 2:", "Dora", "D4,5,6->AzurA,",
          "第二音符:", "Dora", "空维4,5,6", "->胸腺底部",
          "Tone 3:", "Teura", "D7,8,9->Pineal,",
          "第三音符:", "Teura", "空维7,8,9", "->脑中心", "松果体",
          "Tone 4:", "Maharata", "D10,11,12", "+D1 to 9", "->AzurA,",
             "第四音符:", "Maharata", "空维10,11,12", "+空维1到9", "->胸腺底部",
          "Victory Tone:", "Reishi", "Bardoah opens",
            "胜利音符:" , "Reishi", "回魂通道", "打开",
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
          "A-sh-alum- Ta'", "E-ka'sha- deh'",
      "Arhyas Command", "recursively", "(bread first", "search)");

    $this->_KRP_Elemental_Command_sequence = array(
            "In the name of", "the Melchizedek", "Cloister,", "Emerald Order,",
            "以妙基賜德", "寺院，", "綠寶石秩序，",
            "Holy Order of", "the Yunasai,", "Sacred House of ONE",
            "元那塞", "神聖秩序，", "神源一者的", "神聖居屋",
            "In the name of", "the Mashaya-Hana", "Councils of", "Aquareion",
            "以阿夸以昂", "宇宙矩陣的", "馬塞亞－哈那", "理事會的名義",
            "In the name of", "the Councils of", "KrystalA’", "(core Domain",  "Councils)",
            "以圣水晶河", "(核心領域", "理事會)", "的名義",
            "In the name of", "the Councils of", "Krystal River",
            "(Eckasha", "Radonic-", "Edonic-", "Adonic", "Tri-Matrix", "coperative)",
            "以聖水晶河", "理事會", "(易卡沙", "雷當－", "醫當－", "阿當", "之3矩陣", "合作組織", "的名義",
            "In the name of", "the Councils of", "Aurora", "(Tri-Matrix Races",  "of Aquareion)",
            "以極光", "理事會", "(阿夸以昂", "宇宙矩陣的", "3矩陣", "各種族", "天使人類", "的名義)",
            "In the", "Krystic Name", "and Action of", "the AL-Hum-Bhra", "Magistracy", "Councils",
            "of Cosminyahas", "and God-Source", "-1st-Eternal",
            "以AL-HUM-BHRA", "宇宙", "和神源", "第一創造的", "行政", "理事會的", "基督", "名義", "和行動",
            "We call upon", "the Kristiac", "Powers", "of the", "Sha-A’", "Da a-moor",
            "(Eternal",  "Wind-Song", "-jah-sas", "/gases/air)",
            "我們召喚", "Sha-A’", "Da a-moor", "的基督力量", "(永恆的", "風之歌", "－氣)",
            "We call upon", "the Kristiac", "Powers",  "of the", "Jha-et’-A", "Dur-a",
            "(Eternal Flame", "of the", "Divine Fire", "-vapors/fire)",
            "我們召喚", "Jha-et’-A", "Dur-a", "的基督力量", "(永恆的", "聖火", "／煙霧", "／火）",
            "We call upon", "the Kristiac", "Powers", "of the", "Aah-QuA’-el", "(Eternal", "Water Flow", "-fluids/", "liquids", "/waters)",
            "我們召喚", "Aah-Qua-el", "的基督力量", "(永恆的", "水流", "－液／水)",
            "We call upon", "the Kristiac", "Powers", "of the", "et-a-LA’a", "KrystalA’",
            "(Eternal", "Foundation Stone", "-en-tara", "fema/solids)",
            "我們召喚", "et-a-LA’", "KrystalA’", "的基督力量", "(永恆的", "基石－", "固體)",
            "We call upon", "the Kristiac", "Powers", "of the", "E-Ta-Ur’", "Sha-LA",
            "(Eternal Fire", "-Ice-Ethers",  "1st- Radiation)",
            "(breathe)", "(呼吸)",
            "我們召喚", "E-Ta-Ur’", "Sha-LA’", "的基督力量", "(永恆的火", "－冰,", "以太第1輻射)",
            "We now Command", "(co-create", "directly", "with God-Source)",
            "with the", "entrusted Powers", "of", "Aurora Light,",
	     "我們現在", "以受委託的", "極光力量", "而命令", "(与神源", "直接地", "共同创造)",
            "We now", "Invoke", "the Eternal", "Krysted Sun...",
            "我們現在", "呼求永亙的", "基督太陽",
            "to Co-create,", "Release", "and Renew", "this PLACE",
            "(can be", "a location,", "being", "or circumstance", "in space-time",  "manifestation)",
            "來共同創造,", "釋放,", "並換新,", "這個地方",
            "(可以是", "一個在時空", "表象世界", "內的", "地點，", "人物，", "或情况）",
            "(breathe)", "(呼吸)",
            "We now", "Declare", "in Eternal", "Sanctification...",
            "我們現在", "於永恆聖化中", "聲名",
            "This PLACE,", "this LAND", "(or body", "or circumstance", "in healing", "applications),",
            "and All within,", "...", "Into the", "Kristiac", "Protection", "here-in", "set...",
            "這地方，", "土地", "（或在", "治療癒合的", "應用過程中", " 的個體，", "或情行），", "以及在", "其內的", "所
有東西，",
            "進入在此", "設立的", "基督的", "保護之中",
            "...", "that", "the Spirit",  "of Urtha-Sala", "Rise,", "the Power of", "Urtha-Sala", "Heal,",
            "and the", "Wisdom of,",  "Urtha Sala", "here within", "Preside,",
            "那俄薩", "－薩拉的", "精神昇起，", "那俄薩", "－薩拉的", "力量", "治療癒合，", "那俄薩", "－薩拉的", "智慧", "在這里主持，",
        "in the name",  "of the", "Eternal Krist", "of", "1st-Creation", "and by", "the", "Divine Vehicle", "of the", "Rei-ha-VA’-ah", "UN-Krys-ta’-LO",
            "(Krystal River).",
            "以第一", "創造的", "永恆基督", "之名，", "並依靠", "聖水晶河的", "神聖舟車。",
            "(breathe)", "(呼吸)",
            "In Co-Creative", "Krist Embrace,", "with Absolute", "Humility,",  "Absolute Love",
            "and Absolute", "Fore-giving,", "And ONLY", "in", "Absolute Service", "to the", "Eternal Krist",
            "and ITs", "Ever-Loving", "Healing", "Devotion", "to ALL-LIFE", "EVERYWHERE,",
            "We BANISH",  "NOW", "from this", "Sacred PLACE...",
            "all that", "is unwilling", "to receive", "the Absolute", "Cleansing", "of the", "KrystalA’,",
            "within", "the Covenants", "of Divine", "Right Order", "and Divine", "Right Timing,",
            "as ONLY", "Eternal", "God-Source", "can know.",
            "在共同", "創造的", "基督的", "懷抱中，", "以決對", "的謙遜", "決對的", "仁愛", "和決對", "的寬容", "並且僅>在",
 "為永恆", "基督的", "決對服務", "之中，",
            "和在他的", "永遠", "仁愛中的", "對萬物", "生靈的", "治療癒合", "的忠誠里，", "我們現在", "從這", "神聖之地>，", "驅逐", "那所有", "不願接搜", "基督聖洗的", "幽靈",
            "在只有", "永恆神源", "才能知道的",
            "神聖的", "正確次序", "和神聖的", "准確時間的", "約束內的", "聖約之中。",
            "(breathe)", "(呼吸)",
            "In Loving", "Kristiac", "Service", "we offer", "Release", "and", "Host Arrangement", "to All", "those present",
            "whom are", "in need", "and seek to", "HEAL", "within", "the Sacred", "Cleansing Field", "of Urtha-",
            "Sala",  "and the", "Eternal", "Divine Flows", "of the", "Rei-ha-VA’-ah", "UN-Krys-ta’-LO.",
            "在仁愛的", "基督服務中", "我們提供", "釋放，", "和作東主", "的安排，", "給於現在", "全場所有", "有須要", ">並尋求", "在俄薩－",
            "薩拉的", "和聖水晶河", "中的", "神聖", "淨化場", "之中的", "治療癒合", "的生靈。",
            "(breathe)", "(呼吸)",
            "In Kristiac", "Reverence,", "Joy",  "and Gratitude", "for the", "Unceasing Love",
            "and Mercy", "of the ONE-SOURCE", "Most-Divine,",
            "we END NOW", "and COMPLETE", "this Kristiac", "Sanctification", "and", "Salvage Rite",
            "of Reclamation...",
            "在對", "萬物", "之主源的", "仁愛和", "慈悲的", "基督性的", "尊敬，", "歡喜", "和感恩", "之中，", "我們現在", "結束A",
            "並完成", "這個", "基督的聖化",
            "營救", "和矯正", "儀式。",
            "(breathe)", "(呼吸)",
            "In the name of", "the ONE", "-TRUE-", "SOURCE-GOD-", "ETERNAL", "God-Source",
            "以真神源", "之名",
            "In the name of", "the KRIST-", "DIVINE", "(the Eternal", "Krist)",
            "以聖基督", "之名",
            "In the name of", "the Rei-ha-VA’-ah", "UN-Krys-ta’-LO", "(Krystal River)",
            "以聖水晶河", "之名",
            "In the name of", "the Councils", "of KrystalA’", "(Core Domain", "Councils)",
            "以核心領域", "理事會", "之名",
            "In the name of", "the Councils", "of", "Krystal River",
            "(Eckasha", "Radonic-", "Edonic-", "Adonic", "Tri-Matrix",  "Co-operative)",
            "以聖水晶河", "理事會", "之名",
            "In the", "name of", "the Councils",  "of Aurora", "(Tri-Matrix", "Races of",  "Aquareion)",
 "以極光", "理事會", "之名",
            "In the", "name of", "the", "Melchizedek", "Cloister,", "Emerald Order,",
            "以妙基賜德", "寺院，", "綠寶石", "秩序，",
            "Holy Order of", "the Yunasai,", "Sacred", "House of ONE",
            "元那塞", "神聖秩序，", "神源一者的", "神聖居屋", "之名",
            "In the", "Krystic Name", "and Action of", "the AL-Hum-Bhra",  "Magistracy Councils",
            "of Cosminyahas", "and God-Source", "-1st-Eternal",
            "以AL-HUM-BHRA", "宇宙和", "神源", "第一創造的", "行政", "理事會的", "基督", "聖名和行動",
            "And in the ", "name of __",
            "(your common", "or", "spiritual name",  "spoken)-",
            "the Eternally", "Kristiac", "“I AM", "THIS I AM.”",
            "並且以＿", "你的", "通俗名字", "或", "精神名號",
            "－那永恆的", "Ka,", "Ra,", "Ya,", "Sa,", "Ta,", "Ha,", "La", "我就是", "那個我", "之名。",
            "Ta A’jha-", "in’ta", "DO’-A (3 x)",
            "如是聲名", "如是成就", "(3遍)");


    }


    private function string_to_hex($str)
    {
	    $hex = "";
	    for ($i = 0; $i < strlen($str); $i ++)
		    $hex.= dechex(ord($str[$i]));
	    $hex = strtoupper($hex);
	    return $hex;
    }


    private function arhyas_command_ping( $host, $hex_string)
    {
	$command = 'ping -c 1 -p ' . $hex_string . ' ' .  $host;
        $response = shell_exec($command);
        //echo $response;

	/*response = subprocess.run(['ping', '-c', '1', '-p', hex_string[::-1], host], stdout=subprocess.PIPE, text=True)*/
        return $response;
    }

    private function command_sequence($command_name)
    {
	$command_array = array(" ");
	switch($command_name)
	{
	case "ELAi_sa":
		$arrObj = new ArrayObject($this->_ELAi_sa_sequence);
		$command_array = $arrObj->getArrayCopy();
		break;
	case "AL_Hum_Bhra1":
		$arrObj = new ArrayObject($this->_AL_Hum_Bhra_sequence1);
		$command_array = $arrObj->getArrayCopy();
		break;
	case "AL_Hum_Bhra2":
		$arrObj = new ArrayObject($this->_AL_Hum_Bhra_sequence2);
		$command_array = $arrObj->getArrayCopy();
		break;
	case "KRP":
		$arrObj = new ArrayObject($this->_KRP_sequence);
		$command_array = $arrObj->getArrayCopy();
		break;
	case "KRP_Elemental":
		$arrObj = new ArrayObject($this->_KRP_Elemental_Command_sequence);
		$command_array = $arrObj->getArrayCopy();
		break;
	case "Arhyas_Command":
		$arrObj = new ArrayObject($this->_Arhyas_Command_sequence);
		$command_array = $arrObj->getArrayCopy();
		break;
	}

        for($i= 0; $i < count($command_array); $i ++)
	{
            //echo $command_array[$i];
            $command_hex= $this->string_to_hex($command_array[$i]);
            //echo $command_hex;
	    //echo 
	    $this->arhyas_command_ping($this->_ip_addr, $command_hex);
	}
    }



    public function activate()
    {
	    echo $this->_ip_addr;
       	    $this->command_sequence("ELAi_sa");
	    $this->command_sequence("AL_Hum_Bhra1");
            $this->command_sequence("AL_Hum_Bhra2");
            $this->command_sequence("KRP");
            $this->command_sequence("KRP_Elemental");
	    $this->command_sequence("Arhyas_Command");

    }

}
