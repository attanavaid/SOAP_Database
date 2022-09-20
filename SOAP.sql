CREATE TABLE IF NOT EXISTS office (
    office_name varchar(50) not null,
    city varchar(50) not null,
    sq_ft_managed numeric(12, 0) check(sq_ft_managed >= 1),
    primary key (office_name)
);

CREATE TABLE IF NOT EXISTS agency (
    agency_id varchar(8) not null check(length(agency_id) = 8),
    agency_name varchar(50) not null unique,
    address varchar(100),
    city varchar(50),
    phone_number varchar(12) not null unique check(length(phone_number) = 12),
    primary key (agency_id)
);

CREATE TABLE IF NOT EXISTS agreement (
    agreement_id varchar(8) not null check(length(agreement_id) = 8),
    primary key (agreement_id)
);

CREATE TABLE IF NOT EXISTS manages (
    office_name varchar(50) not null,
    agreement_id varchar(8) not null check(length(agreement_id) = 8),
    rent_amount numeric(12, 2) not null check(rent_amount >= 1),
    end_month numeric(2, 0) not null check(end_month >= 1 and end_month <= 12),
    end_day numeric(2, 0) not null check((end_month in (1, 3, 5, 7, 8, 10, 12) and end_day >= 1 and end_day <= 31) or
                                         (end_month = 2 and end_day >= 1 and end_day <= 28) or
                                         (end_month in (4, 6, 9, 11) and end_day >= 1 and end_day <= 30)),
    end_year numeric(4, 0) not null check(end_year >= 2023),
    primary key (agreement_id),
    foreign key (office_name) references office on delete cascade,
    foreign key (agreement_id) references agreement on delete cascade
);

CREATE TABLE IF NOT EXISTS has (
    agency_id varchar(8) not null check(length(agency_id) = 8),
    agreement_id varchar(8) not null check(length(agreement_id) = 8),
    primary key (agency_id, agreement_id),
    foreign key (agency_id) references agency on delete cascade,
    foreign key (agreement_id) references agreement on delete cascade
);

INSERT INTO office VALUES ("New England", "Boston", 3289250560);
INSERT INTO office VALUES ("Northeast and Caribbean", "New York City", 40092508430);
INSERT INTO office VALUES ("Mid-Atlantic", "Philadelphia", 174843201320);
INSERT INTO office VALUES ("Southeast Sunbelt", "Atlanta", 89008218430);
INSERT INTO office VALUES ("Great Lakes", "Chicago", 21098675480);
INSERT INTO office VALUES ("Heartland", "Kansas City", 4357489220);
INSERT INTO office VALUES ("Greater Southwest", "Fort Worth", 6272554220);
INSERT INTO office VALUES ("Rocky Mountain", "Denver", 7348238920);
INSERT INTO office VALUES ("Pacific Rim", "San Francisco", 348947380);
INSERT INTO office VALUES ("Northwest/Arctic", "Seattle", 543832890);
INSERT INTO office VALUES ("National Capital", "Washington D.C.", 946124870);

INSERT INTO agency VALUES ("HH376437", "U.S. Department of Health and Human Services", "200 Independence Avenue S.W.", "Washington D.C.", "877-696-6775");
INSERT INTO agency VALUES ("SA393209", "Social Security Administration", "6401 Security Boulevard", "Woodlawn", "410-965-8882");
INSERT INTO agency VALUES ("FB815742", "Federal Bureau of Investigation", "935 Pennsylvania Avenue N.W.", "Washington D.C.", "202-324-3000");
INSERT INTO agency VALUES ("HS312810", "U.S. Department of Homeland Security", "2703 Martin Luther King Jr Ave S.E.", "Washington D.C.", "202-372-4653");
INSERT INTO agency VALUES ("AA385493", "U.S. Department of Agriculture", "1301 Independence Avenue S.W.", "Washington D.C.", "202-720-2791");
INSERT INTO agency VALUES ("JU075164", "U.S. Department of Justice", "950 Pennsylvania Avenue N.W.", "Washington D.C.", "202-514-2000");
INSERT INTO agency VALUES ("DF832971", "U.S. Department of Defense", "1400 Defense Pentagon", "Washington D.C.", "703-545-6700");
INSERT INTO agency VALUES ("TR438574", "U.S. Department of Transportation", "1200 New Jersey Avenue S.E.", "Washington D.C.", "202-366-4000");
INSERT INTO agency VALUES ("VA340320", "U.S. Department of Veterans Affairs", "4500 South Lancaster Road", "Dallas", "214-742-8387");
INSERT INTO agency VALUES ("MS656531", "U.S. Marshals Service", "1215 South Clark Street", "Arlington", "202-307-9100");

INSERT INTO manages VALUES ("National Capital", "NC543926", 643743.63, 1, 1, 2024);
INSERT INTO manages VALUES ("Mid-Atlantic", "MA710050", 248430.43, 4, 15, 2028);
INSERT INTO manages VALUES ("National Capital", "NC700435", 894161.86, 6, 18, 2032);
INSERT INTO manages VALUES ("National Capital", "NC504589", 749248.22, 3, 23, 2044);
INSERT INTO manages VALUES ("National Capital", "NC894642", 974372.54, 12, 30, 2035);
INSERT INTO manages VALUES ("National Capital", "NC945347", 873973.79, 5, 2, 2027);
INSERT INTO manages VALUES ("Greater Southwest", "GS578436", 757943.18, 9, 15, 2026);

INSERT INTO agreement VALUES ("NC543926");
INSERT INTO agreement VALUES ("MA710050");
INSERT INTO agreement VALUES ("NC700435");
INSERT INTO agreement VALUES ("NC504589");
INSERT INTO agreement VALUES ("NC894642");
INSERT INTO agreement VALUES ("NC945347");
INSERT INTO agreement VALUES ("GS578436");

INSERT INTO has VALUES ("HH376437", "NC543926");
INSERT INTO has VALUES ("SA393209", "MA710050");
INSERT INTO has VALUES ("FB815742", "NC700435");
INSERT INTO has VALUES ("HS312810", "NC504589");
INSERT INTO has VALUES ("AA385493", "NC504589");
INSERT INTO has VALUES ("JU075164", "NC894642");
INSERT INTO has VALUES ("DF832971", "NC543926");
INSERT INTO has VALUES ("TR438574", "NC945347");
INSERT INTO has VALUES ("VA340320", "GS578436");
INSERT INTO has VALUES ("MS656531", "MA710050");