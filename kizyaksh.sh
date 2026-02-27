#!/bin/sh
if [ "$4" == "" ]; then
     echo "🥭 Скачивание репозиториев..."
     vpnsrc=$(curl https://raw.githubusercontent.com/igareck/vpn-configs-for-russia/refs/heads/main/Vless-Reality-White-Lists-Rus-Mobile.txt)
     vpnsrc2=$(curl https://raw.githubusercontent.com/igareck/vpn-configs-for-russia/refs/heads/main/Vless-Reality-White-Lists-Rus-Mobile-2.txt)
     # vpnsrc3=$(curl https://raw.githubusercontent.com/igareck/vpn-configs-for-russia/refs/heads/main/BLACK_VLESS_RUS_mobile.txt)
     vpnsrc3=$(curl https://raw.githubusercontent.com/igareck/vpn-configs-for-russia/refs/heads/main/WHITE-SNI-RU-all.txt)
else
     echo "❗ Скачивание сторонних репозиториев..."
     vpnsrc=$(curl $4)
fi

dryrun=0
dryrun_force=0
show_help=0

if [ "$1" == "--do-nothing" ]; then
     dryrun=1
elif [ "$1" == "--check-time" ]; then
     dryrun_force=1
elif [ "$1" == "--help" ]; then
     dryrun_force=1
     show_help=1
fi
if [ "$2" == "--auto" ]; then
     autoconfig=1
else
     autoconfig=0
fi
if [ "$5" == "" ]; then
     customvpnsrc=""
elif [ "$5" == "--no-custom" ]; then
     customvpn=""
else
     customvpn=$(cat $5)
fi

if [ "$3" == "" ]; then
     profile_name=$(echo "КIЗЯК VPN🥭")
else
     profile_name=$3
fi
clear
echo '"  __   .__                       __
# |  | _|__|__________.__._____  |  | __    ___  ________   ____
# |  |/ /  \___   <   |  |\__  \ |  |/ /    \  \/ /\____ \ /    \
# |    <|  |/    / \___  | / __ \|    <      \   / |  |_> >   |  \
# |__|_ \__/_____ \/ ____|(____  /__|_ \      \_/  |   __/|___|  /
#      \/        \/\/          \/     \/           |__|        \/"'
echo '🥭 КIЗЯК VPN 6 cfg downloader 🥭'
if [ "$(echo "$vpnsrc" | grep 'Date/Time: ')" != "" ]; then
     echo "🥭 Дата обновления репозитория: $(echo "$vpnsrc" | grep 'Date/Time: ')"
else
     echo "🥭 Дата обновления репозитория: недоступно (дата обновления репозитория не указана)"
fi
if [ "$dryrun_force" != "1" ]; then
     if [ "$1" == "" ]; then
          echo "🥭 Введите название файла:"
          read filename
     else
          filename=$1
     fi
     if [ "$(cat "$filename" | grep 'Date/Time: ')" != "" ]; then
          echo "🥭 Дата обновления репозитория из файла: $(cat "$filename" | grep 'Date/Time: ')"
     fi
     if [ "$dryrun" != "1" ]; then
          echo "Записываем конфиг: $filename"
     fi
     if [ "$autoconfig" != "1" ]; then
          read -sp "❗ Нажмите [Enter] для продолжения выполнения..."
     fi
     echo '🥭 Создаем конфиг...'
     if [ "$dryrun" != "1" ]; then
          echo "#profile-title: $profile_name
#profile-desc:🥭🥭🥭
#profile-description:🥭🥭🥭
#profile-serverDescription:🥭🥭🥭
#profile-update-interval: 3
#subscription-userinfo: upload=29; download=12; total=10737418240000000;
#support-url: https://t.me/+KLYYc-t388QwOTEy
#profile-web-page-url: https://t.me/+KLYYc-t388QwOTEy

#🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭
#  __   .__                       __
# |  | _|__|__________.__._____  |  | __    ___  ________   ____
# |  |/ /  \___   <   |  |\__  \ |  |/ /    \  \/ /\____ \ /    \'
# |    <|  |/    / \___  | / __ \|    <      \   / |  |_> >   |  \'
# |__|_ \__/_____ \/ ____|(____  /__|_ \      \_/  |   __/|___|  /
#      \/        \/\/          \/     \/           |__|        \'
#🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭🥭

# Спасибо за конфиги от https://www.github.com/igareck/vpn-configs-for-russia
#%20%5B%2ACIDR%5D
          " > $filename
     fi

     if [ "$4" == "" ]; then
          echo '🥭 Получаем информацию о vpn-configs-for-russia...'
     else
          echo '🥭 Получаем информацию о стороннем репозитории...'
     fi

     rawfile=$(echo "$vpnsrc" && echo "$vpnsrc2" && echo "$vpnsrc3" && echo "$customvpn")
     echo '🥭 Устанавливаем описание CIDR...'
     cidr_new=$(echo "$rawfile" | sed 's/%20%5B%2ACIDR%5D/ [🏳️LTE] | 🥭🔥/g')
     echo '🥭 Устанавливаем описание YA/VK...'
     str_new1=$(echo "$cidr_new" | sed 's/YA/ /g')
     str_new2=$(echo "$str_new1" | sed 's/VK/ /g')
     str_new3=$(echo "$str_new2" | sed 's/Beeline/ /g')
     echo '🥭 Устанавливаем описание SNI...'
     sni_new=$(echo "$str_new3" | sed 's/%20%5BSNI-RU%5D/ | 🥭🔥/g')
     echo '🥭 Устанавливаем описание IPv4...'
     ip4_new=$(echo "$sni_new" | sed 's/%5BIPv4%2B6%5D/🔐/g')
     echo '🥭 Устанавливаем описание IPv6...'
     ip6_new=$(echo "$ip4_new" | sed 's/%20%5BIPv6%5D/ 🔐/g')
     echo '🥭 Устанавливаем описание BL...'
     bl_new=$(echo "$ip6_new" | sed 's/%7C%20%5BBL%5D/[🏴BL]/g')
     echo '🥭 Переименовываем страны...'
     country_ch1=$(echo "$bl_new" | sed 's/Afghanistan/Афганистан/g')
     country_ch2=$(echo "$country_ch1" | sed 's/Albania/Албания/g')
     country_ch3=$(echo "$country_ch2" | sed 's/Algeria/Алжир/g')
     country_ch4=$(echo "$country_ch3" | sed 's/Andorra/Андорра/g')
     country_ch5=$(echo "$country_ch4" | sed 's/Angola/Ангола/g')
     country_ch6=$(echo "$country_ch5" | sed 's/Antigua%20and%20Barbuda/Антигуа и Барбуда/g')
     country_ch7=$(echo "$country_ch6" | sed 's/Argentina/Аргентина/g')
     country_ch8=$(echo "$country_ch7" | sed 's/Armenia/Армения/g')
     country_ch9=$(echo "$country_ch8" | sed 's/Australia/Австралия/g')
     country_ch10=$(echo "$country_ch9" | sed 's/Austria/Австрия/g')
     country_ch11=$(echo "$country_ch10" | sed 's/Azerbaijan/Азербайджан/g')
     country_ch12=$(echo "$country_ch11" | sed 's/Bahamas/Багамы/g')
     country_ch13=$(echo "$country_ch12" | sed 's/Bahrain/Бахрейн/g')
     country_ch14=$(echo "$country_ch13" | sed 's/Bangladesh/Бангладеш/g')
     country_ch15=$(echo "$country_ch14" | sed 's/Barbados/Барбадос/g')
     country_ch16=$(echo "$country_ch15" | sed 's/Belarus/Беларусь/g')
     country_ch17=$(echo "$country_ch16" | sed 's/Belgium/Бельгия/g')
     country_ch18=$(echo "$country_ch17" | sed 's/Belize/Белиз/g')
     country_ch19=$(echo "$country_ch18" | sed 's/Benin/Бенин/g')
     country_ch20=$(echo "$country_ch19" | sed 's/Bhutan/Бутан/g')
     country_ch21=$(echo "$country_ch20" | sed 's/Bolivia/Боливия/g')
     country_ch22=$(echo "$country_ch21" | sed 's/Bosnia%20and%20Herzegovina/Босния и Герцеговина/g')
     country_ch23=$(echo "$country_ch22" | sed 's/Botswana/Ботсвана/g')
     country_ch24=$(echo "$country_ch23" | sed 's/Brazil/Бразилия/g')
     country_ch25=$(echo "$country_ch24" | sed 's/Brunei/Бруней/g')
     country_ch26=$(echo "$country_ch25" | sed 's/Bulgaria/Болгария/g')
     country_ch27=$(echo "$country_ch26" | sed 's/Burkina%20Faso/Буркина-Фасо/g')
     country_ch28=$(echo "$country_ch27" | sed 's/Burundi/Бурунди/g')
     country_ch29=$(echo "$country_ch28" | sed 's/Cabo%20Verde/Кабо-Верде/g')
     country_ch30=$(echo "$country_ch29" | sed 's/Cambodia/Камбоджа/g')
     country_ch31=$(echo "$country_ch30" | sed 's/Cameroon/Камерун/g')
     country_ch32=$(echo "$country_ch31" | sed 's/Canada/Канада/g')
     country_ch33=$(echo "$country_ch32" | sed 's/Central%20African%20Republic/Центральноафриканская Республика/g')
     country_ch34=$(echo "$country_ch33" | sed 's/Chad/Чад/g')
     country_ch35=$(echo "$country_ch34" | sed 's/Chile/Чили/g')
     country_ch36=$(echo "$country_ch35" | sed 's/China/Китай/g')
     country_ch37=$(echo "$country_ch36" | sed 's/Colombia/Колумбия/g')
     country_ch38=$(echo "$country_ch37" | sed 's/Comoros/Коморы/g')
     country_ch39=$(echo "$country_ch38" | sed 's/Congo/Конго/g')
     country_ch40=$(echo "$country_ch39" | sed 's/Costa%20Rica/Коста-Рика/g')
     country_ch41=$(echo "$country_ch40" | sed 's/Cote%20d%27Ivoire/Кот-д’Ивуар/g')
     country_ch42=$(echo "$country_ch41" | sed 's/Croatia/Хорватия/g')
     country_ch43=$(echo "$country_ch42" | sed 's/Cuba/Куба/g')
     country_ch44=$(echo "$country_ch43" | sed 's/Cyprus/Кипр/g')
     country_ch45=$(echo "$country_ch44" | sed 's/Czech%20Republic/Чехия/g')
     country_ch46=$(echo "$country_ch45" | sed 's/Denmark/Дания/g')
     country_ch47=$(echo "$country_ch46" | sed 's/Djibouti/Джибути/g')
     country_ch48=$(echo "$country_ch47" | sed 's/Dominica/Доминика/g')
     country_ch49=$(echo "$country_ch48" | sed 's/Dominican%20Republic/Доминиканская Республика/g')
     country_ch50=$(echo "$country_ch49" | sed 's/Ecuador/Эквадор/g')
     country_ch51=$(echo "$country_ch50" | sed 's/Egypt/Египет/g')
     country_ch52=$(echo "$country_ch51" | sed 's/El%20Salvador/Сальвадор/g')
     country_ch53=$(echo "$country_ch52" | sed 's/Equatorial%20Guinea/Экваториальная Гвинея/g')
     country_ch54=$(echo "$country_ch53" | sed 's/Eritrea/Эритрея/g')
     country_ch55=$(echo "$country_ch54" | sed 's/Estonia/Эстония/g')
     country_ch56=$(echo "$country_ch55" | sed 's/Eswatini/Эсватини/g')
     country_ch57=$(echo "$country_ch56" | sed 's/Ethiopia/Эфиопия/g')
     country_ch58=$(echo "$country_ch57" | sed 's/Fiji/Фиджи/g')
     country_ch59=$(echo "$country_ch58" | sed 's/Finland/Финляндия/g')
     country_ch60=$(echo "$country_ch59" | sed 's/France/Франция/g')
     country_ch61=$(echo "$country_ch60" | sed 's/Gabon/Габон/g')
     country_ch62=$(echo "$country_ch61" | sed 's/Gambia/Гамбия/g')
     country_ch63=$(echo "$country_ch62" | sed 's/Georgia/Грузия/g')
     country_ch64=$(echo "$country_ch63" | sed 's/Germany/Германия/g')
     country_ch65=$(echo "$country_ch64" | sed 's/Ghana/Гана/g')
     country_ch66=$(echo "$country_ch65" | sed 's/Greece/Греция/g')
     country_ch67=$(echo "$country_ch66" | sed 's/Grenada/Гренада/g')
     country_ch68=$(echo "$country_ch67" | sed 's/Guatemala/Гватемала/g')
     country_ch69=$(echo "$country_ch68" | sed 's/Guinea/Гвинея/g')
     country_ch70=$(echo "$country_ch69" | sed 's/Guinea-Bissau/Гвинея-Бисау/g')
     country_ch71=$(echo "$country_ch70" | sed 's/Guyana/Гайана/g')
     country_ch72=$(echo "$country_ch71" | sed 's/Haiti/Гаити/g')
     country_ch73=$(echo "$country_ch72" | sed 's/Honduras/Гондурас/g')
     country_ch74=$(echo "$country_ch73" | sed 's/Hungary/Венгрия/g')
     country_ch75=$(echo "$country_ch74" | sed 's/Iceland/Исландия/g')
     country_ch76=$(echo "$country_ch75" | sed 's/India/Индия/g')
     country_ch77=$(echo "$country_ch76" | sed 's/Indonesia/Индонезия/g')
     country_ch78=$(echo "$country_ch77" | sed 's/Iran/Иран/g')
     country_ch79=$(echo "$country_ch78" | sed 's/Iraq/Ирак/g')
     country_ch80=$(echo "$country_ch79" | sed 's/Ireland/Ирландия/g')
     country_ch81=$(echo "$country_ch80" | sed 's/Israel/Израиль/g')
     country_ch82=$(echo "$country_ch81" | sed 's/Italy/Италия/g')
     country_ch83=$(echo "$country_ch82" | sed 's/Jamaica/Ямайка/g')
     country_ch84=$(echo "$country_ch83" | sed 's/Japan/Япония/g')
     country_ch85=$(echo "$country_ch84" | sed 's/Jordan/Иордания/g')
     country_ch86=$(echo "$country_ch85" | sed 's/Kazakhstan/Казахстан/g')
     country_ch87=$(echo "$country_ch86" | sed 's/Kenya/Кения/g')
     country_ch88=$(echo "$country_ch87" | sed 's/Kiribati/Кирибати/g')
     country_ch89=$(echo "$country_ch88" | sed 's/Kuwait/Кувейт/g')
     country_ch90=$(echo "$country_ch89" | sed 's/Kyrgyzstan/Кыргызстан/g')
     country_ch91=$(echo "$country_ch90" | sed 's/Laos/Лаос/g')
     country_ch92=$(echo "$country_ch91" | sed 's/Latvia/Латвия/g')
     country_ch93=$(echo "$country_ch92" | sed 's/Lebanon/Ливан/g')
     country_ch94=$(echo "$country_ch93" | sed 's/Lesotho/Лесото/g')
     country_ch95=$(echo "$country_ch94" | sed 's/Liberia/Либерия/g')
     country_ch96=$(echo "$country_ch95" | sed 's/Libya/Ливия/g')
     country_ch97=$(echo "$country_ch96" | sed 's/Liechtenstein/Лихтенштейн/g')
     country_ch98=$(echo "$country_ch97" | sed 's/Lithuania/Литва/g')
     country_ch99=$(echo "$country_ch98" | sed 's/Luxembourg/Люксембург/g')
     country_ch100=$(echo "$country_ch99" | sed 's/Madagascar/Мадагаскар/g')
     country_ch101=$(echo "$country_ch100" | sed 's/Malawi/Малави/g')
     country_ch102=$(echo "$country_ch101" | sed 's/Malaysia/Малайзия/g')
     country_ch103=$(echo "$country_ch102" | sed 's/Maldives/Мальдивы/g')
     country_ch104=$(echo "$country_ch103" | sed 's/Mali/Мали/g')
     country_ch105=$(echo "$country_ch104" | sed 's/Malta/Мальта/g')
     country_ch106=$(echo "$country_ch105" | sed 's/Marshall%20Islands/Маршалловы Острова/g')
     country_ch107=$(echo "$country_ch106" | sed 's/Mauritania/Мавритания/g')
     country_ch108=$(echo "$country_ch107" | sed 's/Mauritius/Маврикий/g')
     country_ch109=$(echo "$country_ch108" | sed 's/Mexico/Мексика/g')
     country_ch110=$(echo "$country_ch109" | sed 's/Micronesia/Микронезия/g')
     country_ch111=$(echo "$country_ch110" | sed 's/Moldova/Молдова/g')
     country_ch112=$(echo "$country_ch111" | sed 's/Monaco/Монако/g')
     country_ch113=$(echo "$country_ch112" | sed 's/Mongolia/Монголия/g')
     country_ch114=$(echo "$country_ch113" | sed 's/Montenegro/Черногория/g')
     country_ch115=$(echo "$country_ch114" | sed 's/Morocco/Марокко/g')
     country_ch116=$(echo "$country_ch115" | sed 's/Mozambique/Мозамбик/g')
     country_ch117=$(echo "$country_ch116" | sed 's/Myanmar/Мьянма/g')
     country_ch118=$(echo "$country_ch117" | sed 's/Namibia/Намибия/g')
     country_ch119=$(echo "$country_ch118" | sed 's/Nauru/Науру/g')
     country_ch120=$(echo "$country_ch119" | sed 's/Nepal/Непал/g')
     country_ch121=$(echo "$country_ch120" | sed 's/The%20Netherlands/Нидерланды/g')
     country_ch122=$(echo "$country_ch121" | sed 's/New%20Zealand/Новая Зеландия/g')
     country_ch123=$(echo "$country_ch122" | sed 's/Nicaragua/Никарагуа/g')
     country_ch124=$(echo "$country_ch123" | sed 's/Niger/Нигер/g')
     country_ch125=$(echo "$country_ch124" | sed 's/Nigeria/Нигерия/g')
     country_ch126=$(echo "$country_ch125" | sed 's/North%20Korea/Северная Корея/g')
     country_ch127=$(echo "$country_ch126" | sed 's/North%20Macedonia/Северная Македония/g')
     country_ch128=$(echo "$country_ch127" | sed 's/Norway/Норвегия/g')
     country_ch129=$(echo "$country_ch128" | sed 's/Oman/Оман/g')
     country_ch130=$(echo "$country_ch129" | sed 's/Pakistan/Пакистан/g')
     country_ch131=$(echo "$country_ch130" | sed 's/Palau/Палау/g')
     country_ch132=$(echo "$country_ch131" | sed 's/Palestine/Палестина/g')
     country_ch133=$(echo "$country_ch132" | sed 's/Panama/Панама/g')
     country_ch134=$(echo "$country_ch133" | sed 's/Papua%20New%20Guinea/Папуа — Новая Гвинея/g')
     country_ch135=$(echo "$country_ch134" | sed 's/Paraguay/Парагвай/g')
     country_ch136=$(echo "$country_ch135" | sed 's/Peru/Перу/g')
     country_ch137=$(echo "$country_ch136" | sed 's/Philippines/Филиппины/g')
     country_ch138=$(echo "$country_ch137" | sed 's/Poland/Польша/g')
     country_ch139=$(echo "$country_ch138" | sed 's/Portugal/Португалия/g')
     country_ch140=$(echo "$country_ch139" | sed 's/Qatar/Катар/g')
     country_ch141=$(echo "$country_ch140" | sed 's/Romania/Румыния/g')
     country_ch142=$(echo "$country_ch141" | sed 's/Russia/Россия/g')
     country_ch143=$(echo "$country_ch142" | sed 's/Rwanda/Руанда/g')
     country_ch144=$(echo "$country_ch143" | sed 's/Saint%20Kitts%20and%20Nevis/Сент-Китс и Невис/g')
     country_ch145=$(echo "$country_ch144" | sed 's/Saint%20Lucia/Сент-Люсия/g')
     country_ch146=$(echo "$country_ch145" | sed 's/Saint%20Vincent%20and%20the%20Grenadines/Сент-Винсент и Гренадины/g')
     country_ch147=$(echo "$country_ch146" | sed 's/Samoa/Самоа/g')
     country_ch148=$(echo "$country_ch147" | sed 's/San%20Marino/Сан-Марино/g')
     country_ch149=$(echo "$country_ch148" | sed 's/Sao%20Tome%20and%20Principe/Сан-Томе и Принсипи/g')
     country_ch150=$(echo "$country_ch149" | sed 's/Saudi%20Arabia/Саудовская Аравия/g')
     country_ch151=$(echo "$country_ch150" | sed 's/Senegal/Сенегал/g')
     country_ch152=$(echo "$country_ch151" | sed 's/Serbia/Сербия/g')
     country_ch153=$(echo "$country_ch152" | sed 's/Seychelles/Сейшелы/g')
     country_ch154=$(echo "$country_ch153" | sed 's/Sierra%20Leone/Сьерра-Леоне/g')
     country_ch155=$(echo "$country_ch154" | sed 's/Singapore/Сингапур/g')
     country_ch156=$(echo "$country_ch155" | sed 's/Slovakia/Словакия/g')
     country_ch157=$(echo "$country_ch156" | sed 's/Slovenia/Словения/g')
     country_ch158=$(echo "$country_ch157" | sed 's/Solomon%20Islands/Соломоновы Острова/g')
     country_ch159=$(echo "$country_ch158" | sed 's/Somalia/Сомали/g')
     country_ch160=$(echo "$country_ch159" | sed 's/South%20Africa/Южно-Африканская Республика/g')
     country_ch161=$(echo "$country_ch160" | sed 's/South%20Korea/Южная Корея/g')
     country_ch162=$(echo "$country_ch161" | sed 's/South%20Sudan/Южный Судан/g')
     country_ch163=$(echo "$country_ch162" | sed 's/Spain/Испания/g')
     country_ch164=$(echo "$country_ch163" | sed 's/Sri%20Lanka/Шри-Ланка/g')
     country_ch165=$(echo "$country_ch164" | sed 's/Sudan/Судан/g')
     country_ch166=$(echo "$country_ch165" | sed 's/Suriname/Суринам/g')
     country_ch167=$(echo "$country_ch166" | sed 's/Sweden/Швеция/g')
     country_ch168=$(echo "$country_ch167" | sed 's/Switzerland/Швейцария/g')
     country_ch169=$(echo "$country_ch168" | sed 's/Syria/Сирия/g')
     country_ch170=$(echo "$country_ch169" | sed 's/Taiwan/Тайвань/g')
     country_ch171=$(echo "$country_ch170" | sed 's/Tajikistan/Таджикистан/g')
     country_ch172=$(echo "$country_ch171" | sed 's/Tanzania/Танзания/g')
     country_ch173=$(echo "$country_ch172" | sed 's/Thailand/Таиланд/g')
     country_ch174=$(echo "$country_ch173" | sed 's/Timor-Leste/Восточный Тимор/g')
     country_ch175=$(echo "$country_ch174" | sed 's/Togo/Того/g')
     country_ch176=$(echo "$country_ch175" | sed 's/Tonga/Тонга/g')
     country_ch177=$(echo "$country_ch176" | sed 's/Trinidad%20and%20Tobago/Тринидад и Тобаго/g')
     country_ch178=$(echo "$country_ch177" | sed 's/Tunisia/Тунис/g')
     country_ch179=$(echo "$country_ch178" | sed 's/Turkey/Турция/g')
     country_ch180=$(echo "$country_ch179" | sed 's/Turkmenistan/Туркменистан/g')
     country_ch181=$(echo "$country_ch180" | sed 's/Tuvalu/Тувалу/g')
     country_ch182=$(echo "$country_ch181" | sed 's/Uganda/Уганда/g')
     country_ch183=$(echo "$country_ch182" | sed 's/Ukraine/Украина/g')
     country_ch184=$(echo "$country_ch183" | sed 's/United%20Arab%20Emirates/Объединенные Арабские Эмираты/g')
     country_ch185=$(echo "$country_ch184" | sed 's/United%20Kingdom/Великобритания/g')
     country_ch186=$(echo "$country_ch185" | sed 's/United%20States/Соединенные Штаты/g')
     country_ch187=$(echo "$country_ch186" | sed 's/Uruguay/Уругвай/g')
     country_ch188=$(echo "$country_ch187" | sed 's/Uzbekistan/Узбекистан/g')
     country_ch189=$(echo "$country_ch188" | sed 's/Vanuatu/Вануату/g')
     country_ch190=$(echo "$country_ch189" | sed 's/Vatican%20City/Ватикан/g')
     country_ch191=$(echo "$country_ch190" | sed 's/Venezuela/Венесуэла/g')
     country_ch192=$(echo "$country_ch191" | sed 's/Vietnam/Вьетнам/g')
     country_ch193=$(echo "$country_ch192" | sed 's/Yemen/Йемен/g')
     country_ch194=$(echo "$country_ch193" | sed 's/Zambia/Замбия/g')
     country_ch195=$(echo "$country_ch194" | sed 's/Zimbabwe/Зимбабве/g')

     echo '🥭 Записываем изменения...'
     if [ "$dryrun" != "1" ]; then
          echo "$country_ch195" >> $filename
     fi
     if [ "$autoconfig" != "1" ]; then
          if [ "$dryrun" != "1" ]; then
               echo '🥭 Открытие файла для предпросмотра...'
               sleep 0.5
               less $filename
          fi
     fi
     # echo '🥭 Запуск пинга всех серверов...'
     # /bin/sh '/home/kostyann/Рабочий стол/kizyak-vpn-4.0/ipsort.sh'
     # echo "❗ Удалить не отвечающие сервера? (y/n)"
     # read del_timeoutosrv
     # if [ "$del_timeoutosrv" == "y" ]; then
     #      sed 's|/|\\/|g; s|.*|/&/d|' ping_results.txt | sed -f - $filename > .temp000002.txt && mv .temp000002.txt $filename
     # fi

     if [ "$autoconfig" != "1" ]; then
          echo "❗ Отправляю файл на сервер? (y/n)"
          read send_tosrv
          if [ "$dryrun" != "1" ]; then
               if [ "$send_tosrv" == "y" ]; then
               git pull
               echo '❗ Отправляю файл на сервер...'
               git add $filename
               git commit -m "обновление от $(date)"
               git push
               # sed -i "1i обновление от $(date)"
               fi
          fi


          if [ "$1" != "" ]; then
               echo "🥭 Вы хотите получить QR-код файла? (y/n)"
               read qr_show
               if [ "$qr_show" == "y" ]; then
                    if [ "$dryrun" != "1" ]; then
                         qrencode -o .temp000001.png $(echo 'https://raw.githubusercontent.com/Maskkost93/kizyak-vpn-4.0/refs/heads/main/'$filename)
                         xdg-open .temp000001.png
                    fi

               fi
          fi
     else
          git pull
          echo '❗ Отправляю файл на сервер...'
          git add $filename
          git commit -m "обновление от $(date)"
          git push
          qrencode -o .temp000001.png $(echo 'https://raw.githubusercontent.com/Maskkost93/kizyak-vpn-4.0/refs/heads/main/'$filename)
          # xdg-open .temp000001.png
     fi
fi

if [ "$show_help" == "1" ]; then
     echo "
🥭❗ Использование скрипта: ./kizyaksh.sh [НАЗВАНИЕ ФАЙЛА|--do-nothing|--check-time|--help] [--auto|--no-auto] [ИМЯ ПРОФИЛЯ] [АДРЕСА СТОРОННИХ РЕПОЗИТОРИЕВ] [--no-custom|ФАЙЛ С ПОЛЬЗОВАТЕЛЬСКИМИ СЕРВЕРАМИ]
     "
fi

echo '🥭 Все операции завершены.'

if [ "$show_help" != "1" ]; then
     notify-send -a kizyaksh "Все операции завершены." -i /home/kostyann/kizyak-vpn-4.0/iconmango.png -A ОК -n /home/kostyann/kizyak-vpn-4.0/iconmango.png "Все этапы создания конфига были пройдены. Конфиг соохранен в $filename" &
fi

echo '🥭🥭🥭 Готово!'

if [ "$autoconfig" != "1" ]; then
     echo " "
     echo "-------------"
     echo "Программа завершена. Чтобы выйти нажмите любую клавишу..."
     echo "-------------"
     read -sn1
fi
