-- CreateCostumeDatabase.sql
-- Create the Costume database 
-- 
-- Revision History
--     mmorell, 2019/10/09: Created
--                         
----------------------------------------------------
-- All data concerning people in this script
-- is taken out of context, scrambled or fabricated.
----------------------------------------------------

------------------------------------------------------
-- For best results using Microsoft SQL Server Manager
-- set Query > Results > Results to Text 
------------------------------------------------------

----------------------------------------------------------------------------
-- Uncomment the ROLLBACK TRANSACTION command below if the script fails 
-- while a transaction is pending. Error messages when this occurs include:
--
-- ALTER DATABASE statement not allowed within multi-statement transaction.
--
-- DROP DATABASE statement cannot be used inside a user transaction.
--
-- CREATE DATABASE statement not allowed within multi-statement transaction.
--
----------------------------------------------------------------------------
-- ROLLBACK TRANSACTION;

DECLARE @version NCHAR(10);
SET @version = '1.0';

PRINT '******************************';
PRINT 'CreateCostumeDatabase.sql Starting';
PRINT 'Script Version ' + @version;
PRINT '******************************'

GO

USE Master;
SET NOCOUNT ON;

GO

PRINT '>>> Does a Costume database already exist?';

GO 

IF EXISTS (SELECT "name"
           FROM Sysdatabases
           WHERE "name" = 'Costume')    
    BEGIN
        PRINT '>>> Yes, a Costume database already exists';
        PRINT '>>> Rolling back pending Costume transactions';
         
        ALTER DATABASE Costume
            SET SINGLE_USER
            WITH ROLLBACK IMMEDIATE;
 
        PRINT '>>> Dropping the existing Costume database';   
        
        DROP DATABASE Costume;
    END
ELSE
    BEGIN
        PRINT '>>> No, there is no Costume database';    
    END
GO

PRINT '>>> Creating a new Costume database';

GO

CREATE DATABASE Costume;

GO
use master;
GO
 
ALTER DATABASE Costume
SET COMPATIBILITY_LEVEL = 120; 
 
USE Costume;
GO

USE Costume;
SET ANSI_PADDING ON;

GO

PRINT '**********';
PRINT 'Encryption';
PRINT '**********';

PRINT '>>> Creating the Encryption Master Key';

GO

CREATE MASTER KEY ENCRYPTION
    BY PASSWORD = 'x1baLbax1baLbax1baLba';
    
GO

PRINT '>>> Creating the Encryption Certificate';

GO

CREATE CERTIFICATE costumeCertificate	
    WITH SUBJECT = 'Costume Database';
GO

PRINT '>>> Creating the Encryption Symmetric Key';

GO

CREATE SYMMETRIC KEY costumeSymmetricKey
    WITH ALGORITHM = TRIPLE_DES
    ENCRYPTION BY CERTIFICATE costumeCertificate;
    
GO

PRINT '******************';
PRINT 'User Defined Types';
PRINT '******************';

GO

--=================
-- EmailAddressType
--=================

-- According to RFC 5321 the maximum size of an email address
-- is 254 characters. In ordinary usage 80 characters
-- should be sufficient.
IF EXISTS (SELECT "name" 
           FROM sys.types 
           WHERE "name" = 'EmailAddressType')
    BEGIN    
        PRINT '>>> User Defined Type EmailAddressType Already Exists';      
--        DROP TYPE EmailAddressType;
    END

GO

PRINT '>>> Creating User Defined Type EmailAddressType';

GO

CREATE TYPE EmailAddressType FROM NVARCHAR(80);

GO

--==============
-- Country Table
--==============

PRINT '>>> Creating the Country Table';

GO

CREATE TABLE Country
(
 code NCHAR(3) NOT NULL
      CONSTRAINT Country_PK 
      PRIMARY KEY CLUSTERED,
 alpha2Code NCHAR(2) NOT NULL,    
 "name" NVARCHAR(50) NOT NULL,
 frenchName NVARCHAR(50) NOT NULL
);

GO

INSERT INTO Country VALUES ('ABW', 'AW', 'ARUBA', 'ARUBA');
INSERT INTO Country VALUES ('AFG', 'AF', 'AFGHANISTAN', 'AFGHANISTAN');
INSERT INTO Country VALUES ('AGO', 'AO', 'ANGOLA', 'ANGOLA');
INSERT INTO Country VALUES ('AIA', 'AI', 'ANGUILLA', 'ANGUILLA');
INSERT INTO Country VALUES ('ALA', 'AX', 'ÅLAND ISLANDS', 'ÅLAND, ÎLES');
INSERT INTO Country VALUES ('ALB', 'AL', 'ALBANIA', 'ALBANIE');
INSERT INTO Country VALUES ('AND', 'AD', 'ANDORRA', 'ANDORRE');
INSERT INTO Country VALUES ('ANT', 'AN', 'NETHERLANDS ANTILLES', 'ANTILLES NÉERLANDAISES');
INSERT INTO Country VALUES ('ARE', 'AE', 'UNITED ARAB EMIRATES', 'ÉMIRATS ARABES UNIS');
INSERT INTO Country VALUES ('ARG', 'AR', 'ARGENTINA', 'ARGENTINE');
INSERT INTO Country VALUES ('ARM', 'AM', 'ARMENIA', 'ARMÉNIE');
INSERT INTO Country VALUES ('ASM', 'AS', 'AMERICAN SAMOA', 'SAMOA AMÉRICAINES');
INSERT INTO Country VALUES ('ATA', 'AQ', 'ANTARCTICA', 'ANTARCTIQUE');
INSERT INTO Country VALUES ('ATF', 'TF', 'FRENCH SOUTHERN TERRITORIES', 'TERRES AUSTRALES FRANÇAISES');
INSERT INTO Country VALUES ('ATG', 'AG', 'ANTIGUA AND BARBUDA', 'ANTIGUA-ET-BARBUDA');
INSERT INTO Country VALUES ('AUS', 'AU', 'AUSTRALIA', 'AUSTRALIE');
INSERT INTO Country VALUES ('AUT', 'AT', 'AUSTRIA', 'AUTRICHE');
INSERT INTO Country VALUES ('AZE', 'AZ', 'AZERBAIJAN', 'AZERBAÏDJAN');
INSERT INTO Country VALUES ('BDI', 'BI', 'BURUNDI', 'BURUNDI');
INSERT INTO Country VALUES ('BEL', 'BE', 'BELGIUM', 'BELGIQUE');
INSERT INTO Country VALUES ('BEN', 'BJ', 'BENIN', 'BÉNIN');
INSERT INTO Country VALUES ('BFA', 'BF', 'BURKINA FASO', 'BURKINA FASO');
INSERT INTO Country VALUES ('BGD', 'BD', 'BANGLADESH', 'BANGLADESH');
INSERT INTO Country VALUES ('BGR', 'BG', 'BULGARIA', 'BULGARIE');
INSERT INTO Country VALUES ('BHR', 'BH', 'BAHRAIN', 'BAHREÏN');
INSERT INTO Country VALUES ('BHS', 'BS', 'BAHAMAS', 'BAHAMAS');
INSERT INTO Country VALUES ('BIH', 'BA', 'BOSNIA AND HERZEGOVINA', 'BOSNIE-HERZÉGOVINE');
INSERT INTO Country VALUES ('BLM', 'BL', 'SAINT BARTHÉLEMY', 'SAINT-BARTHÉLEMY'); 
INSERT INTO Country VALUES ('BLR', 'BY', 'BELARUS', 'BÉLARUS');
INSERT INTO Country VALUES ('BLZ', 'BZ', 'BELIZE', 'BELIZE');
INSERT INTO Country VALUES ('BMU', 'BM', 'BERMUDA', 'BERMUDES'); 
INSERT INTO Country VALUES ('BOL', 'BO', 'BOLIVIA', 'BOLIVIE'); 
INSERT INTO Country VALUES ('BRA', 'BR', 'BRAZIL', 'BRÉSIL'); 
INSERT INTO Country VALUES ('BRB', 'BB', 'BARBADOS', 'BARBADE'); 
INSERT INTO Country VALUES ('BRN', 'BN', 'BRUNEI DARUSSALAM', 'BRUNÉI DARUSSALAM'); 
INSERT INTO Country VALUES ('BTN', 'BT', 'BHUTAN', 'BHOUTAN');
INSERT INTO Country VALUES ('BVT', 'BV', 'BOUVET ISLAND', 'BOUVET, ÏLE'); 
INSERT INTO Country VALUES ('BWA', 'BW', 'BOTSWANA', 'BOTSWANA'); 
INSERT INTO Country VALUES ('CAF', 'CF', 'CENTRAL AFRICAN REPUBLIC', 'CENTRAFRICAINE, RÉPUBLIQUE');
INSERT INTO Country VALUES ('CAN', 'CA', 'CANADA', 'CANADA');
INSERT INTO Country VALUES ('CCK', 'CC', 'COCOS (KEELING) ISLANDS', 'COCOS (KEELING), ÎLES'); 
INSERT INTO Country VALUES ('CHE', 'CH', 'SWITZERLAND', 'SUISSE'); 
INSERT INTO Country VALUES ('CHL', 'CL', 'CHILE', 'CHILI'); 
INSERT INTO Country VALUES ('CHN', 'CN', 'CHINA', 'CHINE'); 
INSERT INTO Country VALUES ('CIV', 'CI', 'CÔTE D''IVOIRE', 'CÔTE D''IVOIRE'); 
INSERT INTO Country VALUES ('CMR', 'CM', 'CAMEROON', 'CAMEROUN');
INSERT INTO Country VALUES ('COD', 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'CONGO, LA RÉPUBLIQUE DÉMOCRATIQUE DU'); 
INSERT INTO Country VALUES ('COG', 'CG', 'CONGO', 'CONGO');
INSERT INTO Country VALUES ('COK', 'CK', 'COOK ISLANDS', 'COOK, ÎLES');
INSERT INTO Country VALUES ('COL', 'CO', 'COLOMBIA', 'COLOMBIE');
INSERT INTO Country VALUES ('COM', 'KM', 'COMOROS', 'COMORES');
INSERT INTO Country VALUES ('CPV', 'CV', 'CAPE VERDE', 'CAP-VERT');
INSERT INTO Country VALUES ('CRI', 'CR', 'COSTA RICA', 'COSTA RICA');
INSERT INTO Country VALUES ('CUB', 'CU', 'CUBA', 'CUBA');
INSERT INTO Country VALUES ('CXR', 'CX', 'CHRISTMAS ISLAND', 'CHRISTMAS, ÎLE');
INSERT INTO Country VALUES ('CYM', 'KY', 'CAYMAN ISLANDS', 'CAÏMANES, ÎLES');
INSERT INTO Country VALUES ('CYP', 'CY', 'CYPRUS', 'CHYPRE');
INSERT INTO Country VALUES ('CZE', 'CZ', 'CZECH REPUBLIC', 'TCHÈQUE, RÉPUBLIQUE');
INSERT INTO Country VALUES ('DEU', 'DE', 'GERMANY', 'ALLEMAGNE');
INSERT INTO Country VALUES ('DJI', 'DJ', 'DJIBOUTI', 'DJIBOUTI');
INSERT INTO Country VALUES ('DMA', 'DM', 'DOMINICA', 'DOMINIQUE');
INSERT INTO Country VALUES ('DNK', 'DK', 'DENMARK', 'DANEMARK');
INSERT INTO Country VALUES ('DOM', 'DO', 'DOMINICAN REPUBLIC', 'DOMINICAINE, RÉPUBLIQUE');
INSERT INTO Country VALUES ('DZA', 'DZ', 'ALGERIA', 'ALGÉRIE');
INSERT INTO Country VALUES ('ECU', 'EC', 'ECUADOR', 'ÉQUATEUR');
INSERT INTO Country VALUES ('EGY', 'EG', 'EGYPT', 'ÉGYPTE');
INSERT INTO Country VALUES ('ERI', 'ER', 'ERITREA', 'ÉRYTHRÉE');
INSERT INTO Country VALUES ('ESH', 'EH', 'WESTERN SAHARA', 'SAHARA OCCIDENTAL');
INSERT INTO Country VALUES ('ESP', 'ES', 'SPAIN', 'ESPAGNE');
INSERT INTO Country VALUES ('EST', 'EE', 'ESTONIA', 'ESTONIE');
INSERT INTO Country VALUES ('ETH', 'ET', 'ETHIOPIA', 'ÉTHIOPIE');
INSERT INTO Country VALUES ('FIN', 'FI', 'FINLAND', 'FINLANDE');
INSERT INTO Country VALUES ('FJI', 'FJ', 'FIJI', 'FIDJI');
INSERT INTO Country VALUES ('FLK', 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'FALKLAND, ÎLES (MALVINAS)');
INSERT INTO Country VALUES ('FRA', 'FR', 'FRANCE', 'FRANCE');
INSERT INTO Country VALUES ('FRO', 'FO', 'FAROE ISLANDS', 'FÉROÉ, ÎLES');
INSERT INTO Country VALUES ('FSM', 'FM', 'MICRONESIA, FEDERATED STATES OF', 'MICRONÉSIE, ÉTATS FÉDÉRÉS DE');
INSERT INTO Country VALUES ('GAB', 'GA', 'GABON', 'GABON');
INSERT INTO Country VALUES ('GBR', 'GB', 'UNITED KINGDOM', 'ROYAUME-UNI');
INSERT INTO Country VALUES ('GEO', 'GE', 'GEORGIA', 'GÉORGIE');
INSERT INTO Country VALUES ('GGY', 'GG', 'GUERNSEY', 'GUERNESEY');
INSERT INTO Country VALUES ('GHA', 'GH', 'GHANA', 'GHANA');
INSERT INTO Country VALUES ('GIB', 'GI', 'GIBRALTAR', 'GIBRALTAR');
INSERT INTO Country VALUES ('GIN', 'GN', 'GUINEA', 'GUINÉE');
INSERT INTO Country VALUES ('GLP', 'GP', 'GUADELOUPE', 'GUADELOUPE');
INSERT INTO Country VALUES ('GMB', 'GM', 'GAMBIA', 'GAMBIE');
INSERT INTO Country VALUES ('GNE', 'GW', 'GUINEA-BISSAU', 'GUINÉE-BISSAU');
INSERT INTO Country VALUES ('GNQ', 'GQ', 'EQUATORIAL GUINEA', 'GUINÉE ÉQUATORIALE');
INSERT INTO Country VALUES ('GRC', 'GR', 'GREECE', 'GRÈCE');
INSERT INTO Country VALUES ('GRD', 'GD', 'GRENADA', 'GRENADE');
INSERT INTO Country VALUES ('GRL', 'GL', 'GREENLAND', 'GROENLAND');
INSERT INTO Country VALUES ('GTM', 'GT', 'GUATEMALA', 'GUATEMALA');
INSERT INTO Country VALUES ('GUF', 'GF', 'FRENCH GUIANA', 'GUYANE FRANÇAISE');
INSERT INTO Country VALUES ('GUM', 'GU', 'GUAM', 'GUAM');
INSERT INTO Country VALUES ('GUY', 'GY', 'GUYANA', 'GUYANA');
INSERT INTO Country VALUES ('HKG', 'HK', 'HONG KONG', 'HONG-KONG');
INSERT INTO Country VALUES ('HMD', 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'HEARD, ÎLE ET MCDONALD, ÎLES');
INSERT INTO Country VALUES ('HND', 'HN', 'HONDURAS', 'HONDURAS');
INSERT INTO Country VALUES ('HRV', 'HR', 'CROATIA', 'CROATIE');
INSERT INTO Country VALUES ('HTI', 'HT', 'HAITI', 'HAÏTI');
INSERT INTO Country VALUES ('HUN', 'HU', 'HUNGARY', 'HONGRIE');
INSERT INTO Country VALUES ('IDN', 'ID', 'INDONESIA', 'INDONÉSIE');
INSERT INTO Country VALUES ('IMN', 'IM', 'ISLE OF MAN', 'ÎLE DE MAN');
INSERT INTO Country VALUES ('IND', 'IN', 'INDIA', 'INDE');
INSERT INTO Country VALUES ('IOT', 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'TERRITOIRE BRITANNIQUE DE L''OCEAN INDIEN');
INSERT INTO Country VALUES ('IRL', 'IE', 'IRELAND', 'IRLANDE');
INSERT INTO Country VALUES ('IRN', 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'IRAN, RÉPUBLIQUE ISLAMIQUE D''');
INSERT INTO Country VALUES ('IRQ', 'IQ', 'IRAQ', 'IRAQ');
INSERT INTO Country VALUES ('ISL', 'IS', 'ICELAND', 'ISLANDE');
INSERT INTO Country VALUES ('ISR', 'IL', 'ISRAEL', 'ISRAËL');
INSERT INTO Country VALUES ('ITA', 'IT', 'ITALY', 'ITALIE');
INSERT INTO Country VALUES ('JAM', 'JM', 'JAMAICA', 'JAMAÏQUE');
INSERT INTO Country VALUES ('JEY', 'JE', 'JERSEY', 'JERSEY');
INSERT INTO Country VALUES ('JOR', 'JO', 'JORDAN', 'JORDANIE');
INSERT INTO Country VALUES ('JPN', 'JP', 'JAPAN', 'JAPON');
INSERT INTO Country VALUES ('KAZ', 'KZ', 'KAZAKHSTAN', 'KAZAKHSTAN');
INSERT INTO Country VALUES ('KEN', 'KE', 'KENYA', 'KENYA');
INSERT INTO Country VALUES ('KGZ', 'KG', 'KYRGYZSTAN', 'KIRGHIZISTAN');
INSERT INTO Country VALUES ('KHM', 'KH', 'CAMBODIA', 'CAMBODGE');
INSERT INTO Country VALUES ('KIR', 'KI', 'KIRIBATI', 'KIRIBATI');
INSERT INTO Country VALUES ('KNA', 'KN', 'SAINT KITTS AND NEVIS', 'SAINT-KITTS-ET-NEVIS');
INSERT INTO Country VALUES ('KOR', 'KR', 'KOREA, REPUBLIC OF', 'CORÉE, RÉPUBLIQUE DE');
INSERT INTO Country VALUES ('KWT', 'KW', 'KUWAIT', 'KOWEÏT');
INSERT INTO Country VALUES ('LAO', 'LA', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC', 'LAO, RÉPUBLIQUE DÉMOCRATIQUE POPULAIRE');
INSERT INTO Country VALUES ('LBN', 'LB', 'LEBANON', 'LIBAN');
INSERT INTO Country VALUES ('LBR', 'LR', 'LIBERIA', 'LIBÉRIA');
INSERT INTO Country VALUES ('LBY', 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'LIBYENNE, JAMAHIRIYA ARABE');
INSERT INTO Country VALUES ('LCA', 'LC', 'SAINT LUCIA', 'SAINTE-LUCIE');
INSERT INTO Country VALUES ('LKA', 'LK', 'SRI LANKA', 'SRI LANKA');
INSERT INTO Country VALUES ('LIE', 'LI', 'LIECHTENSTEIN', 'LIECHTENSTEIN');
INSERT INTO Country VALUES ('LSO', 'LS', 'LESOTHO', 'LESOTHO');
INSERT INTO Country VALUES ('LTU', 'LT', 'LITHUANIA', 'LITUANIE');
INSERT INTO Country VALUES ('LUX', 'LU', 'LUXEMBOURG', 'LUXEMBOURG');
INSERT INTO Country VALUES ('LVA', 'LV', 'LATVIA', 'LETTONIE');
INSERT INTO Country VALUES ('MAC', 'MO', 'MACAO', 'MACAO');
INSERT INTO Country VALUES ('MAF', 'MF', 'SAINT MARTIN', 'SAINT-MARTIN');
INSERT INTO Country VALUES ('MAR', 'MA', 'MOROCCO', 'MAROC');
INSERT INTO Country VALUES ('MCO', 'MC', 'MONACO', 'MONACO');
INSERT INTO Country VALUES ('MDA', 'MD', 'MOLDOVA, REPUBLIC OF', 'MOLDOVA, RÉPUBLIQUE DE');
INSERT INTO Country VALUES ('MDG', 'MG', 'MADAGASCAR', 'MADAGASCAR');
INSERT INTO Country VALUES ('MDV', 'MV', 'MALDIVES', 'MALDIVES');
INSERT INTO Country VALUES ('MEX', 'MX', 'MEXICO', 'MEXIQUE');
INSERT INTO Country VALUES ('MHL', 'MH', 'MARSHALL ISLANDS', 'MARSHALL, ÎLES');
INSERT INTO Country VALUES ('MKD', 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'MACÉDOINE, L''EX-RÉPUBLIQUE YOUGOSLAVE DE');
INSERT INTO Country VALUES ('MLI', 'ML', 'MALI', 'MALI');
INSERT INTO Country VALUES ('MLT', 'MT', 'MALTA', 'MALTE');
INSERT INTO Country VALUES ('MMR', 'MM', 'MYANMAR', 'MYANMAR');
INSERT INTO Country VALUES ('MNE', 'ME', 'MONTENEGRO', 'MONTÉNÉGRO');
INSERT INTO Country VALUES ('MNG', 'MN', 'MONGOLIA', 'MONGOLIE');
INSERT INTO Country VALUES ('MNP', 'MP', 'NORTHERN MARIANA ISLANDS', 'MARIANNES DU NORD, ÎLES');
INSERT INTO Country VALUES ('MOZ', 'MZ', 'MOZAMBIQUE', 'MOZAMBIQUE');
INSERT INTO Country VALUES ('MRT', 'MR', 'MAURITANIA', 'MAURITANIE');
INSERT INTO Country VALUES ('MSR', 'MS', 'MONTSERRAT', 'MONTSERRAT');
INSERT INTO Country VALUES ('MTQ', 'MQ', 'MARTINIQUE', 'MARTINIQUE');
INSERT INTO Country VALUES ('MUS', 'MU', 'MAURITIUS', 'MAURICE');
INSERT INTO Country VALUES ('MWI', 'MW', 'MALAWI', 'MALAWI');
INSERT INTO Country VALUES ('MYS', 'MY', 'MALAYSIA', 'MALAISIE');
INSERT INTO Country VALUES ('MYT', 'YT', 'MAYOTTE', 'MAYOTTE');
INSERT INTO Country VALUES ('NAM', 'NA', 'NAMIBIA', 'NAMIBIE');
INSERT INTO Country VALUES ('NCL', 'NC', 'NEW CALEDONIA', 'NOUVELLE-CALÉDONIE');
INSERT INTO Country VALUES ('NER', 'NE', 'NIGER', 'NIGER');
INSERT INTO Country VALUES ('NFK', 'NF', 'NORFOLK ISLAND', 'NORFOLK, ÎLE');
INSERT INTO Country VALUES ('NGA', 'NG', 'NIGERIA', 'NIGÉRIA');
INSERT INTO Country VALUES ('NIC', 'NI', 'NICARAGUA', 'NICARAGUA');
INSERT INTO Country VALUES ('NIU', 'NU', 'NIUE', 'NIUÉ');
INSERT INTO Country VALUES ('NLD', 'NL', 'NETHERLANDS', 'PAYS-BAS');
INSERT INTO Country VALUES ('NOR', 'NO', 'NORWAY', 'NORVÈGE');
INSERT INTO Country VALUES ('NPL', 'NP', 'NEPAL', 'NÉPAL');
INSERT INTO Country VALUES ('NRU', 'NR', 'NAURU', 'NAURU');
INSERT INTO Country VALUES ('NZL', 'NZ', 'NEW ZEALAND', 'NOUVELLE-ZÉLANDE');
INSERT INTO Country VALUES ('OMN', 'OM', 'OMAN', 'OMAN');
INSERT INTO Country VALUES ('PAK', 'PK', 'PAKISTAN', 'PAKISTAN');
INSERT INTO Country VALUES ('PAN', 'PA', 'PANAMA', 'PANAMA');
INSERT INTO Country VALUES ('PCN', 'PN', 'PITCAIRN', 'PITCAIRN');
INSERT INTO Country VALUES ('PER', 'PE', 'PERU', 'PÉROU');
INSERT INTO Country VALUES ('PHL', 'PH', 'PHILIPPINES', 'PHILIPPINES');
INSERT INTO Country VALUES ('PLW', 'PW', 'PALAU', 'PALAOS');
INSERT INTO Country VALUES ('PNG', 'PG', 'PAPUA NEW GUINEA', 'PAPOUASIE-NOUVELLE-GUINÉE');
INSERT INTO Country VALUES ('POL', 'PL', 'POLAND', 'POLOGNE');
INSERT INTO Country VALUES ('PRI', 'PR', 'PUERTO RICO', 'PORTO RICO');
INSERT INTO Country VALUES ('PRK', 'KP', 'KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF', 'CORÉE, RÉPUBLIQUE POPULAIRE DÉMOCRATIQUE D''');
INSERT INTO Country VALUES ('PRT', 'PT', 'PORTUGAL', 'PORTUGAL');
INSERT INTO Country VALUES ('PRY', 'PY', 'PARAGUAY', 'PARAGUAY');
INSERT INTO Country VALUES ('PSE', 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'PALESTINIEN OCCUPÉ, TERRITOIRE');
INSERT INTO Country VALUES ('PYF', 'PF', 'FRENCH POLYNESIA', 'POLYNÉSIE FRANÇAISE');
INSERT INTO Country VALUES ('QAT', 'QA', 'QATAR', 'QATAR');
INSERT INTO Country VALUES ('REU', 'RE', 'REUNION', 'RÉUNION');
INSERT INTO Country VALUES ('ROU', 'RO', 'ROMANIA', 'ROUMANIE');
INSERT INTO Country VALUES ('RUS', 'RU', 'RUSSIAN FEDERATION', 'RUSSIE, FÉDÉRATION DE');
INSERT INTO Country VALUES ('RWA', 'RW', 'RWANDA', 'RWANDA');
INSERT INTO Country VALUES ('SAU', 'SA', 'SAUDI ARABIA', 'ARABIE SAOUDITE');
INSERT INTO Country VALUES ('SCA', 'TC', 'TURKS AND CAICOS ISLANDS', 'TURKS ET CAÏQUES, ÎLES');
INSERT INTO Country VALUES ('SDN', 'SD', 'SUDAN', 'SOUDAN');
INSERT INTO Country VALUES ('SEN', 'SN', 'SENEGAL', 'SÉNÉGAL');
INSERT INTO Country VALUES ('SGP', 'SG', 'SINGAPORE', 'SINGAPOUR');
INSERT INTO Country VALUES ('SGS', 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'GÈORGIE DU SUD ET LES ÎLES SANDWICH DU SUD');
INSERT INTO Country VALUES ('SHN', 'SH', 'SAINT HELENA', 'SAINTE-HÉLÈNE');
INSERT INTO Country VALUES ('SJM', 'SJ', 'SVALBARD AND JAN MAYEN', 'SVALBARD ET ÎLE JAN MAYEN');
INSERT INTO Country VALUES ('SLB', 'SB', 'SOLOMON ISLANDS', 'SALOMON, ÎLES');
INSERT INTO Country VALUES ('SLE', 'SL', 'SIERRA LEONE', 'SIERRA LEONE');
INSERT INTO Country VALUES ('SLV', 'SV', 'EL SALVADOR', 'EL SALVADOR');
INSERT INTO Country VALUES ('SMR', 'SM', 'SAN MARINO', 'SAINT-MARIN');
INSERT INTO Country VALUES ('SOM', 'SO', 'SOMALIA', 'SOMALIE');
INSERT INTO Country VALUES ('SPM', 'PM', 'SAINT PIERRE AND MIQUELON', 'SAINT-PIERRE-ET-MIQUELON');
INSERT INTO Country VALUES ('SRB', 'RS', 'SERBIA', 'SERBIE');
INSERT INTO Country VALUES ('STP', 'ST', 'SAO TOME AND PRINCIPE', 'SAO TOMÉ-ET-PRINCIPE');
INSERT INTO Country VALUES ('SUR', 'SR', 'SURINAME', 'SURINAME');
INSERT INTO Country VALUES ('SVK', 'SK', 'SLOVAKIA', 'SLOVAQUIE');
INSERT INTO Country VALUES ('SVN', 'SI', 'SLOVENIA', 'SLOVÉNIE');
INSERT INTO Country VALUES ('SWE', 'SE', 'SWEDEN', 'SUÈDE');
INSERT INTO Country VALUES ('SWZ', 'SZ', 'SWAZILAND', 'SWAZILAND');
INSERT INTO Country VALUES ('SYC', 'SC', 'SEYCHELLES', 'SEYCHELLES');
INSERT INTO Country VALUES ('SYR', 'SY', 'SYRIAN ARAB REPUBLIC', 'SYRIENNE, RÉPUBLIQUE ARABE');
INSERT INTO Country VALUES ('TCD', 'TD', 'CHAD', 'TCHAD');
INSERT INTO Country VALUES ('TGO', 'TG', 'TOGO', 'TOGO');
INSERT INTO Country VALUES ('THA', 'TH', 'THAILAND', 'THAÏLANDE');
INSERT INTO Country VALUES ('TJK', 'TJ', 'TAJIKISTAN', 'TADJIKISTAN');
INSERT INTO Country VALUES ('TKL', 'TK', 'TOKELAU', 'TOKELAU');
INSERT INTO Country VALUES ('TKM', 'TM', 'TURKMENISTAN', 'TURKMÉNISTAN');
INSERT INTO Country VALUES ('TLS', 'TL', 'TIMOR-LESTE', 'TIMOR-LESTE');
INSERT INTO Country VALUES ('TON', 'TO', 'TONGA', 'TONGA');
INSERT INTO Country VALUES ('TTO', 'TT', 'TRINIDAD AND TOBAGO', 'TRINITÉ-ET-TOBAGO');
INSERT INTO Country VALUES ('TUN', 'TN', 'TUNISIA', 'TUNISIE');
INSERT INTO Country VALUES ('TUR', 'TR', 'TURKEY', 'TURQUIE');
INSERT INTO Country VALUES ('TUV', 'TV', 'TUVALU', 'TUVALU');
INSERT INTO Country VALUES ('TWN', 'TW', 'TAIWAN, PROVINCE OF CHINA', 'TAÏWAN, PROVINCE DE CHINE');
INSERT INTO Country VALUES ('TZA', 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'TANZANIE, RÉPUBLIQUE-UNIE DE');
INSERT INTO Country VALUES ('UGA', 'UG', 'UGANDA', 'OUGANDA');
INSERT INTO Country VALUES ('UKR', 'UA', 'UKRAINE', 'UKRAINE');
INSERT INTO Country VALUES ('UMI', 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'ÎLES MINEURES ÉLOIGNÉES DES ÉTATS-UNIS');
INSERT INTO Country VALUES ('URY', 'UY', 'URUGUAY', 'URUGUAY');
INSERT INTO Country VALUES ('USA', 'US', 'UNITED STATES', 'ÉTATS-UNIS');
INSERT INTO Country VALUES ('UZB', 'UZ', 'UZBEKISTAN', 'OUZBÉKISTAN');
INSERT INTO Country VALUES ('VAT', 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'SAINT-SIÈGE (ÉTAT DE LA CITÉ DU VATICAN)');
INSERT INTO Country VALUES ('VCT', 'VC', 'SAINT VINCENT AND THE GRENADINES', 'SAINT-VINCENT-ET-LES GRENADINES');
INSERT INTO Country VALUES ('VEN', 'VE', 'VENEZUELA', 'VENEZUELA');
INSERT INTO Country VALUES ('VGB', 'VG', 'VIRGIN ISLANDS, BRITISH', 'ÎLES VIERGES BRITANNIQUES');
INSERT INTO Country VALUES ('VIR', 'VI', 'VIRGIN ISLANDS, U.S.', 'ÎLES VIERGES DES ÉTATS-UNIS');
INSERT INTO Country VALUES ('VNM', 'VN', 'VIET NAM', 'VIET NAM');
INSERT INTO Country VALUES ('VUT', 'VU', 'VANUATU', 'VANUATU');
INSERT INTO Country VALUES ('WLF', 'WF', 'WALLIS AND FUTUNA', 'WALLIS ET FUTUNA');
INSERT INTO Country VALUES ('WSM', 'WS', 'SAMOA', 'SAMOA');
INSERT INTO Country VALUES ('YEM', 'YE', 'YEMEN', 'YÉMEN');
INSERT INTO Country VALUES ('ZAF', 'ZA', 'SOUTH AFRICA', 'AFRIQUE DU SUD');
INSERT INTO Country VALUES ('ZMB', 'ZM', 'ZAMBIA', 'ZAMBIE');
INSERT INTO Country VALUES ('ZWE', 'ZW', 'ZIMBABWE', 'ZIMBABWE');

GO

--===============
-- Province Table
--===============

PRINT '>>> Creating the Province Table';

CREATE TABLE Province
(
 code NCHAR(2) NOT NULL
      CONSTRAINT Province_PK 
      PRIMARY KEY CLUSTERED,
 countryCode NCHAR(3) NOT NULL,
 "name" NCHAR(50) NOT NULL,
 frenchName NCHAR(50) NOT NULL,

 CONSTRAINT Province_Country_FK
     FOREIGN KEY (countryCode)
     REFERENCES Country(code)
);

GO

INSERT INTO Province VALUES ('AB', 'CAN', 'ALBERTA', 'ALBERTA');
INSERT INTO Province VALUES ('BC', 'CAN', 'BRITISH COLUMBIA', 'COLOMBIE-BRITANNIQUE');
INSERT INTO Province VALUES ('MB', 'CAN', 'MANITOBA', 'MANITOBA');
INSERT INTO Province VALUES ('NB', 'CAN', 'NEW BRUNSWICK', 'NOUVEAU-BRUNSWICK'); 
INSERT INTO Province VALUES ('NL', 'CAN', 'NEWFOUNDLAND AND LABRADOR', 'TERRE-NEUVE-ET-LABRADOR');
INSERT INTO Province VALUES ('NT', 'CAN', 'NORTHWEST TERRITORIES', 'TERRITOIRES DU NORD-OUEST');
INSERT INTO Province VALUES ('NS', 'CAN', 'NOVA SCOTIA', 'NOUVELLE-ÉCOSSE');
INSERT INTO Province VALUES ('NU', 'CAN', 'NUNAVUT', 'NUNAVUT');
INSERT INTO Province VALUES ('ON', 'CAN', 'ONTARIO', 'ONTARIO');
INSERT INTO Province VALUES ('PE', 'CAN', 'PRINCE EDWARD ISLAND', 'ÎLE-DU-PRINCE-ÉDOUARD');
INSERT INTO Province VALUES ('QC', 'CAN', 'QUÉBEC', 'QUÉBEC');
INSERT INTO Province VALUES ('SK', 'CAN', 'SASKATCHEWAN', 'SASKATCHEWAN');
INSERT INTO Province VALUES ('YT', 'CAN', 'YUKON', 'YUKON');
INSERT INTO Province VALUES ('AL', 'USA', 'ALABAMA', 'ALABAMA');
INSERT INTO Province VALUES ('AK', 'USA', 'ALASKA', 'ALASKA');
INSERT INTO Province VALUES ('AS', 'USA', 'AMERICAN SAMOA', 'SAMOA AMÉRICAINES');
INSERT INTO Province VALUES ('AZ', 'USA', 'ARIZONA', 'ARIZONA');
INSERT INTO Province VALUES ('AR', 'USA', 'ARKANSAS', 'ARKANSAS');
INSERT INTO Province VALUES ('AA', 'USA', 'ARMED FORCES AMERICAS(EXCEPT CANADA)', 'FORCES ARMÉES DES AMÉRIQUES (sauf le Canada)');
INSERT INTO Province VALUES ('AE', 'USA', 'ARMED FORCES AFRICA CANADA EUROPE MIDDLE EAST', 'FORCES ARMÉES Europe Moyen-AFRIQUE DU CANADA EST');
INSERT INTO Province VALUES ('AP', 'USA', 'ARMED FORCES PACIFIC', 'FORCES ARMÉES DU PACIFIQUE');
INSERT INTO Province VALUES ('CA', 'USA', 'CALIFORNIA', 'CALIFORNIA');
INSERT INTO Province VALUES ('CO', 'USA', 'COLORADO', 'COLORADO');
INSERT INTO Province VALUES ('CT', 'USA', 'CONNECTICUT', 'CONNECTICUT');
INSERT INTO Province VALUES ('DE', 'USA', 'DELAWARE', 'DELAWARE');
INSERT INTO Province VALUES ('DC', 'USA', 'DISTRICT OF COLUMBIA', 'DISTRICT DE COLUMBIA');
INSERT INTO Province VALUES ('FL', 'USA', 'FLORIDA', 'FLORIDA');
INSERT INTO Province VALUES ('GA', 'USA', 'GEORGIA', 'GEORGIA');
INSERT INTO Province VALUES ('GU', 'USA', 'GUAM', 'GUAM');
INSERT INTO Province VALUES ('HI', 'USA', 'HAWAII', 'HAWAII');
INSERT INTO Province VALUES ('ID', 'USA', 'IDAHO', 'IDAHO');
INSERT INTO Province VALUES ('IL', 'USA', 'ILLINOIS', 'ILLINOIS');
INSERT INTO Province VALUES ('IN', 'USA', 'INDIANA', 'INDIANA');
INSERT INTO Province VALUES ('IA', 'USA', 'IOWA', 'IOWA');
INSERT INTO Province VALUES ('KS', 'USA', 'KANSAS', 'KANSAS');
INSERT INTO Province VALUES ('KY', 'USA', 'KENTUCKY', 'KENTUCKY');
INSERT INTO Province VALUES ('LA', 'USA', 'LOUISIANA', 'LOUISIANA');
INSERT INTO Province VALUES ('ME', 'USA', 'MAINE', 'MAINE');
INSERT INTO Province VALUES ('MH', 'USA', 'MARSHALL ISLANDS', 'ÎLES MARSHALL');
INSERT INTO Province VALUES ('MD', 'USA', 'MARYLAND', 'MARYLAND');
INSERT INTO Province VALUES ('MA', 'USA', 'MASSACHUSETTS', 'MASSACHUSETTS');
INSERT INTO Province VALUES ('MI', 'USA', 'MICHIGAN', 'MICHIGAN');
INSERT INTO Province VALUES ('FM', 'USA', 'MICRONESIA (FEDERATED STATES OF)', 'MICRONÉSIE (ÉTATS FÉDÉRÉS DE)');
INSERT INTO Province VALUES ('MN', 'USA', 'MINNESOTA', 'MINNESOTA');
INSERT INTO Province VALUES ('UM', 'USA', 'MINOR OUTLYING ISLANDS', 'ÎLES MINEURES ÉLOIGNÉES');
INSERT INTO Province VALUES ('MS', 'USA', 'MISSISSIPPI', 'MISSISSIPPI');
INSERT INTO Province VALUES ('MO', 'USA', 'MISSOURI', 'MISSOURI');
INSERT INTO Province VALUES ('MT', 'USA', 'MONTANA', 'MONTANA');
INSERT INTO Province VALUES ('NE', 'USA', 'NEBRASKA', 'NEBRASKA');
INSERT INTO Province VALUES ('NV', 'USA', 'NEVADA', 'NEVADA');
INSERT INTO Province VALUES ('NH', 'USA', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE');
INSERT INTO Province VALUES ('NJ', 'USA', 'NEW JERSEY', 'NEW JERSEY');
INSERT INTO Province VALUES ('NM', 'USA', 'NEW MEXICO', 'NEW MEXICO');
INSERT INTO Province VALUES ('NY', 'USA', 'NEW YORK', 'NEW YORK');
INSERT INTO Province VALUES ('NC', 'USA', 'NORTH CAROLINA', 'NORTH CAROLINA');
INSERT INTO Province VALUES ('ND', 'USA', 'NORTH DAKOTA', 'NORTH DAKOTA');
INSERT INTO Province VALUES ('MP', 'USA', 'NORTHERN MARIANA ISLANDS', 'NORTHERN MARIANA ISLANDS');
INSERT INTO Province VALUES ('OH', 'USA', 'OHIO', 'OHIO');
INSERT INTO Province VALUES ('OK', 'USA', 'OKLAHOMA', 'OAKLAHOMA');
INSERT INTO Province VALUES ('OR', 'USA', 'OREGON', 'OREGON');
INSERT INTO Province VALUES ('PW', 'USA', 'PALAU', 'PALAU');
INSERT INTO Province VALUES ('PA', 'USA', 'PENNSYLVANIA', 'PENNSYLVANIA');
INSERT INTO Province VALUES ('PR', 'USA', 'PUERTO RICO', 'PUERTO RICO');
INSERT INTO Province VALUES ('RI', 'USA', 'RHODE ISLAND', 'RHODE ISLAND');
INSERT INTO Province VALUES ('SC', 'USA', 'SOUTH CAROLINA', 'CAROLINE DU SUD');
INSERT INTO Province VALUES ('SD', 'USA', 'SOUTH DAKOTA', 'DAKOTA DU SUD');
INSERT INTO Province VALUES ('TN', 'USA', 'TENNESSEE', 'TENNESSEE');
INSERT INTO Province VALUES ('TX', 'USA', 'TEXAS', 'TEXAS');
INSERT INTO Province VALUES ('UT', 'USA', 'UTAH', 'UTAH');
INSERT INTO Province VALUES ('VT', 'USA', 'VERMONT', 'VERMONT');
INSERT INTO Province VALUES ('VI', 'USA', 'VIRGIN ISLANDS', 'VIRGIN ISLANDS');
INSERT INTO Province VALUES ('VA', 'USA', 'VIRGINIA', 'VIRGINIA');
INSERT INTO Province VALUES ('WA', 'USA', 'WASHINGTON', 'WASHINGTON');
INSERT INTO Province VALUES ('WV', 'USA', 'WEST VIRGINIA', 'VIRGINIE OCCIDENTALE');
INSERT INTO Province VALUES ('WI', 'USA', 'WISCONSIN', 'WISCONSIN');
INSERT INTO Province VALUES ('WY', 'USA', 'WYOMING', 'WYOMING');

GO

--============================
-- ScareRating Table
--============================

PRINT '>>> Creating the ScareRating Table';

GO

CREATE TABLE ScareRating
(
 id                 INT NOT NULL
     CONSTRAINT ScareRating_PK
     PRIMARY KEY CLUSTERED,
 scareRatingDescription NVARCHAR(100) NOT NULL
);

GO

INSERT INTO ScareRating ( id, scareRatingDescription ) VALUES (10,  'Not Scary');
INSERT INTO ScareRating ( id, scareRatingDescription ) VALUES (20,  'Slightly Frightening');
INSERT INTO ScareRating ( id, scareRatingDescription ) VALUES (40,  'Moderately Scary');
INSERT INTO ScareRating ( id, scareRatingDescription ) VALUES (60,  'Scary');
INSERT INTO ScareRating ( id, scareRatingDescription ) VALUES (80,  'Very Scary and Gory');
INSERT INTO ScareRating ( id, scareRatingDescription ) VALUES (100,  'Absolutely Terrifying!');

GO

--============================
-- Costume Table
--============================

PRINT '>>> Creating the Costume Table';

GO

CREATE TABLE Costume
(
 id                 INT IDENTITY NOT NULL
     CONSTRAINT Costume_PK
     PRIMARY KEY CLUSTERED,
 costumeName        NVARCHAR(80) NOT NULL,
 costumeDescription NVARCHAR(200),
 numPieces          INT	NOT NULL,
 colour		        NVARCHAR(15),
 scareRatingId      INT NOT NULL, 
 comments	        NVARCHAR(200),
 upcCode	        VARCHAR(15)

  CONSTRAINT Costume_ScareRating_FK
     FOREIGN KEY (scareRatingId)
     REFERENCES ScareRating(id)
);

GO

SET IDENTITY_INSERT Costume ON;

INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (1,  'Dracula', 'Black flowing cape, amulet, vampire teeth', 3, 'Black', 40, NULL, '03423538230');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (2,  'Frankenstein', 'Jacket, pants, electroids, makeup', 4, 'Green', 40, NULL, '0293847320');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (3,  'Zombie', 'Tattered clothing, mask', 2, 'Brown', 60, NULL, '930329493823');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (4,  'Mummy', 'Bandages', 1, 'White', 40, 'Hard to keep wound up', '09384723610');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (5,  'Clown', 'Nose, shoes, flower, hat, makeup', 5, 'Multi', 20, 'Nice clown', '093837642930');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (6,  'Freddy', 'Mask, hat and fingers', 3, 'Red', 60, NULL, '09838372390');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (7,  'Sunflower', 'Big flower', 1, 'Yellow', 10, NULL, '086243743840');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (8,  'Mountie', 'Pants, jacket, hat, gloves', 4, 'Red', 10, NULL, '0735239362');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (9,  'Soldier', 'One piece uniform, helmet', 2, 'Green', 20, NULL, '08735273913');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (10,  'Candy Bar', 'Chocolate bar outfit', 1, 'Brown', 10, NULL, '087626389260');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (11,  'Witchdoctor', 'Mask, staff, wig', 3, 'Black', 60, NULL, '0432637365273');
INSERT INTO Costume (id, costumeName, costumeDescription, numPieces, colour, scareRatingId, comments, upcCode)
VALUES (12,  'Ghost', 'Flowing robe with headpiece', 1, 'White', 60, NULL, '0872734723');

SET IDENTITY_INSERT Costume OFF;

GO

--============================
-- CostumeInventory Table
--============================

PRINT '>>> Creating the CostumeInventory Table';

GO

CREATE TABLE CostumeInventory
(
 costumeId          INT NOT NULL,
 numberInStock      INT NOT NULL,
 numberOnOrder      INT,
 numberLost         INT

  CONSTRAINT Costume_Inventory_FK
     FOREIGN KEY (costumeId)
     REFERENCES Costume(id)
);

GO
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 1, 15, 10, 0 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 2, 20, 5, 3 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 3, 17, 10, 1 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 4, 5, 20, 2);
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 5, 20, 19, 4);
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 6, 3, 1, 2 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 7, 2, 2, 5 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 8, 1, 1, 0 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 9, 5, 2, 3 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 10, 1, 0, 7 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 11, 3, 2, 0 );
INSERT INTO CostumeInventory (costumeID, numberInStock, numberOnOrder, numberLost )
VALUES( 12, 30, 5, 3 );

--============================
-- CostumeRental Table
--============================

PRINT '>>> Creating the CostumeRental Table';

GO

CREATE TABLE CostumeRental
(
  id                 INT IDENTITY NOT NULL
     CONSTRAINT CostumeRental_PK
     PRIMARY KEY CLUSTERED,
  costumeId          INT NOT NULL,
  rentedToFirstName  NVARCHAR(50) NOT NULL,
  rentedToLastName   NVARCHAR(50) NOT NULL,
  rentedDate         DATETIME2 NOT NULL,
  returnedDate       DATETIME2,
  returnedDamaged    BIT,
  rentalComments     NVARCHAR(200)

  CONSTRAINT Costume_Rental_FK
     FOREIGN KEY (costumeId)
     REFERENCES Costume(id)
);

GO
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 1, 'George', 'Maxwell', CONVERT(datetime, '2019-10-04 2:11 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 1, 'Doug', 'Graves', CONVERT(datetime, '2019-10-01 11:11 AM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 1, 'Ivory', 'Fang', CONVERT(datetime, '2019-10-07 2:57 PM'), CONVERT(datetime, '2019-10-09 4:17 PM'), 0, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 12, 'Ima', 'Phantom', CONVERT(datetime, '2018-09-15 7:26 PM'), CONVERT(datetime, '2019-01-04 9:18 PM'), 1, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 12, 'Ullas', 'Osef', CONVERT(datetime, '2018-08-31 9:19 AM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 2, 'Frank', 'Stein', CONVERT(datetime, '2019-07-11 5:31 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 2, 'Billy', 'Orwell', CONVERT(datetime, '2019-10-09 6:32 PM'), CONVERT(datetime, '2019-10-10 8:57 AM'), 0, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 3, 'Rob', 'Just', CONVERT(datetime, '2019-09-27 4:34 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 3, 'Rick', 'Grimes', CONVERT(datetime, '2018-11-23 1:30 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 3, 'Julie', 'Gzund', CONVERT(datetime, '2019-10-05 11:11 PM'), CONVERT(datetime, '2019-10-06 2:12 PM'), 0, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 3, 'Paige', 'Isenthal', CONVERT(datetime, '2019-09-21 5:43 PM'), CONVERT(datetime, '2019-09-30 8:35 PM'), 1, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 3, 'Scott', 'McHolland', CONVERT(datetime, '2019-08-31 9:59 AM'), CONVERT(datetime, '2019-09-05 4:14 PM'), 1, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 3, 'Rachel', 'Scruff', CONVERT(datetime, '2019-10-05 3:12 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 4, 'Sadie', 'Ninten', CONVERT(datetime, '2018-03-04 5:06 PM'), CONVERT(datetime, '2018-07-04 2:10 PM'), 0, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 9, 'Greg', 'Shepherd', CONVERT(datetime, '2018-10-23 8:13 PM'), CONVERT(datetime, '2018-10-27 4:15 PM'), 0, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 5, 'Chris', 'Gore', CONVERT(datetime, '2019-10-01 12:11 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 8, 'George', 'Dolittle', CONVERT(datetime, '2019-08-22 2:22 PM'), CONVERT(datetime, '2018-10-01 4:23 PM'), 0, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 7, 'Andre', 'Lafleur', CONVERT(datetime, '2019-09-09 9:09 AM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 7, 'Andrea', 'Yan', CONVERT(datetime, '2019-10-09 7:42 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 11, 'Tara', 'Oconnor', CONVERT(datetime, '2019-10-05 7:31 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 11, 'Ima', 'Phantom', CONVERT(datetime, '2018-01-04 9:25 PM'), NULL, NULL, NULL );
INSERT INTO CostumeRental (costumeID, rentedToFirstName, rentedToLastName, rentedDate, returnedDate, returnedDamaged, rentalComments )
VALUES( 12, 'Doug', 'Graves', CONVERT(datetime, '2019-10-03 12:12 AM'), NULL, NULL, NULL );

--====
-- EOF
--====