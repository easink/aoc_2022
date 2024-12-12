defmodule AoCDay15Test do
  use ExUnit.Case

  # @test_input_ttt """
  # 8
  # """
  # @test_input_tt """
  # 12
  # 23
  # """
  # @test_input_t """
  # 116
  # 138
  # 213
  # """

  @test_input """
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
  """

  @input """
  1611211251115912246318291351712232221112291225613417396681596333922111215456315139438667612549131941
  8932114117311575142243171112817226232119863432221628251318261661191181914131437113236733419511921113
  3311112319881299126138992415428219269217291531671353324111619434247412712947881243552169128135998191
  2519114235316687331115265422264283428712233596112945181199111152385542971123592212311162661421311721
  1382461356912146511842319166317957261971229314621394111613112824713571111351337871924493182613432256
  5114711863712392214191153831119241119273761167659431242745167938327311529213316381831112912163261726
  2133551185321341121928148131837914911121496412338312251193532149215486158331691323639142596645122111
  1711569246152189932234173111631965298489584111312431711132154431213342671841478551877131719115182119
  9122149481122135915537133111611623234859281656147415218627843119137181419118649192615139557824552374
  4911523117167829117391221297181113512124212111923552525313422843324691463742313599316131243752253684
  5414417111829212132324935672161432171112458323991236122391625212798322322229323469836523865422521221
  6411419531652111283121918212256619646644819331891775249312384935234199392273946162322562911231297881
  2128729415918832321163943197715389275338541111113951736132921133694314913712199421116532211811753165
  4155523539192111125923842191181996311591936139684321893331918133513841219121725123321178229123219131
  9479285145913396251237128221525362732111772949515352815229526959117541561311121638422294521121411186
  5361431713278166762792211821131161119224248551162317662211612621114112115836126641192459222212113327
  2494757131117376374123218127935211421161131174291195896246235724212194112343914127851943372836444151
  1126333352124135364191315839321423442739332131119751918814928429539165252271192793931114699193141352
  7993476425955975972523385123991731131227922419193851353711242334711754713176123716252617514911343624
  3837633187113119153159621661333345499733158211731234919113375757122732611351412411224458275312113323
  1213823111311973291166152828314699226174131294182312323228596132434921226112127148541491997311661191
  1941285148119221112175922114193977135939237888391111177353313353689991314261133271214122191599821736
  8119315121159215398141511314171194211295753133431893571741116342288969422281953477211127122222213973
  3211111167199143898758411863181981129346176513322864719479111538191232861611116115119312419947645553
  1116492399643291188637718819419298121111918367194662558912163995311127427114328911165321911938295897
  5221341524613111111223219421487242918173161311123534127423239989283232112859413129411118482547249611
  2221112419417121234321411525226131119681871293873972521124131841952617392731118211645272733175695623
  9612345322815334929511532521673436495145189314311416112129421593214128111119235149113134463374743313
  1244221693131322581451147117421391191864425622293214124341731361291125663915221114141621411362821278
  2172253112327761111869591591622634435924853217231815881111128255855675618865529681213195121163164521
  5743111872122589683117162112882841163318223322251188355331721123578419616834686786529121123113218593
  3321161112491141116159313111431514931151434445121713391782311211112188453711967181121569227119699721
  7512453185178912811919718138316122226148122383921386636142313119496642377384231129986892299376621781
  3113599931452121119619213654414531351118185111248215332182424311317111178972225269831323284339236238
  9912366294321341583781633214743179594932161437249186115152411911369753336382255511323199954813623728
  1314711821143992615365323742237972221289177334988151971416866117414415987181446288212921318291872287
  1624323218114569968532411252451323154227171182184321146819515242113128613341112811137258318916548332
  1195511352111831237947711128751752123921434481581332911154674751178836895113494129677169311468467511
  1863122261482612323595412171126851273311324418253578198211196382173948331667691631411433864291121391
  3122131239163387493384638361292847829627718461433891215125431265311315821112996425882765126561237115
  9911861321475453331414812557311159914929131473161814111427321154399431161191225423116724752189845823
  8151641221153511138821713126551323968737187495942257223319592116321152816393654749195121842859351561
  1166117415617912214512233311622311349827111971281785282815252122131242554221212241132169312158111271
  2233996127755859511239121167379563381398219339928131397735621213582199233313911145982592291244594129
  8569151891541511111461248226124157912265892366222218221872634432811432182612229317181291524711139591
  5412311262782192614933281411582713218722165267517317328522142495131291471384412276125722597121434111
  4173541913248981189134359164156111911121424819924627122149411627829189431144112131161789527537415321
  6199541772813361931132121169128154757113922428416775411215491988894985711765281981294312137712596211
  5251419132285971615119119177942242443621167411481133191239129831611177111334811322714342335212111579
  1211672567181413837159338619362214593438571282737841891171811922112975413195436813376511357913889116
  6914528121947132224243611758351474856334243631714152291226249163141142233286146216271151727381151169
  1871184111221765954832861441175634212721111212163252244115391345154411384118131211297436312614113428
  3557196222191552169112122212625667121963141445463531367892145241154113939211239289676471619622335121
  8567338617111541261391871614787255952111293114637631145121311622153232556918911718514211615412216141
  3944121182193414694117121173381311212142432119146149621727971611129135332923129117951215298211269685
  1111592571437471142981893366164971251413314142436483167321549514181212232343999516918983819933236711
  2375115619131214293975661177135192182233622431221411615114284928141121112272113151119724411224972212
  1145312314943244314182211125113132121152177139345496164699415321632281441514462841822959821322912811
  1128221793138934439154535119891154314517512192822451911664244177187311411881591162215129524277142942
  6921947132116612163531511516186151192965868417146111719495941314413311391186879899168572141191251821
  3186112191177114711191511274113892212111986111184132611486471323117534245765967313831244815411149751
  7211143432211162819111341412884428411157442849137112139891933941951342191473171151339821319247144849
  1131113162196912112827566145361732144314447154315612293272485153184992426631931523811115124359133865
  2281351241119151142551963821187631141146729957878815111212296647772312131896111211121435246213415112
  6613911666125516111611198421146871358716222211126181284827422512433151939174162969714755332383281551
  1314838958146117922189891941512614221122283989927215899611211552121843851111181341741142862615891571
  1184414114322239212541616362157152294513233374491318461448714111519235422661798718171439241333431296
  9311816362385233444141981596131861168924891222652896114258832451273331121448932163431364431164713512
  1712984142627979443581394797712382615719949171481235263498912867711341219911315133743566529611474376
  1718233118179567122847133769922353161321539632555611121981121731282117121198481422621181544275958977
  1965611713311299491119831837156322619154487176611728193194757471222195131333111191133639479288145129
  1925143767879899127119296284583131662912411236971684115512125122995914975232517512847426331989161132
  4499267153717255561739216833131923245176337118314966821513423353715111317591526423211571894215118187
  6579124183396925714615176324644214696647734416475522221315511135949232212422214239431992312238376121
  9422683256329462113113721585689491163835132226239324123952341945732131113122223192114515783614231313
  2155691356142542121131351729332713931122531151137795833172153367423193842872211218197921147111831296
  2316296411941633442127418259415912992294191164991361512885441591856325534682915231823857139781651122
  9145636137281236355296215512749138944731311141277711621121111498691212276268831522715182159527772777
  3224122132239918842916762517116151661619122978482962411115113411995381473218465123135111322141134939
  6582351117483126471318349319471541111917442217717826322613365376294124112591671131243119511279414331
  6423952732261724348136382963134472539218234399242771194234392191432797697271349538712139262173323939
  5995413228134633761812711113695646455338171181624111194996368911812318641817184264325113531133191771
  1161351263343243681321468581721652196519161223416276521842811111224136921281256361216611912232865513
  2185132121111682961259657424131224958141284152159882687111141923263321231218111258572158565191221314
  2817225411782624419714272493347261556461522152931965215218223824912411171151744891113912194137111423
  1579421337169822546441817285517972381181324434929391762124311161134381199823232531412315824999419213
  3397433594321463666814912371119113783382222111221112984248888113935751232163134138754215731563528193
  3142471143234221613116412482441787257711122117635393189121212512552831411161239125913133111811135743
  3892129761474512987363928223283161741741136114411532151214231333431431221937142357114251112998852553
  5541195316631416357251394178322219446412481895123714849951917522182335426248194849111296984119159115
  6135415326645125142212956869181913111276972623139411379444646921626426393126519431231627738414519415
  7251911292354759133915441134817595316198333184811718729171311322429315768358628238138131651543153821
  1429314149329291981111115452911258119831371787279311981671662216716411183121183216117779949145194819
  9446771212175891141141332112891165219141111999616597311271116422955215881561111292111311146215473192
  2521861131871723318434421918715152965195611181488289421611546398635412427117931218893287513626244111
  8153191121156911192812112313211137214128163295685421243114341139614913113191157196121836348767226615
  7191223694191111525131311232587511392919411121716188943799133588811321333393142496522191428461621541
  4311991831229124542211761611121912789517192135112141341544155561111164536149942489792274122235211192
  1955255328184197192291393141191318135231142911827322211178376698122131997147521924327551211333124525
  2327268121248272713243282411262957517495392942118222115384214211191592248992511958919114295121113911
  """

  test "part1" do
    # assert AoC.Day15.part1(@test_input_t) == 9
    assert AoC.Day15.part1(@test_input) == 40
    assert AoC.Day15.part1(@input) == 363
  end

  @tag timeout: :infinity
  test "part2" do
    assert AoC.Day15.part2(@test_input) == 315
    assert AoC.Day15.part2(@input) == 2835
  end
end