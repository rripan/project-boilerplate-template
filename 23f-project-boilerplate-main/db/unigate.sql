CREATE DATABASE UniGate;
USE UniGate;

-- Create the tables
-- Table: Person
CREATE TABLE Person (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB char,
    Type ENUM('Applicant', 'Guidance Counsellor', 'Admissions counsellor') NOT NULL
);

-- Table: Applicant
CREATE TABLE Applicant (
    ApplicantID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    HighSchool VARCHAR(100) NOT NULL,
    DepositID INT,
    ApplicationID INT,
    SurveyID INT,
    CONSTRAINT FK_Applicant_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: GuidanceCounsellor
CREATE TABLE GuidanceCounsellor (
    GuidanceCounsellorID INT PRIMARY KEY,
    PersonID INT NOT NULL,
    HighSchool VARCHAR(100) NOT NULL,
    CONSTRAINT FK_GuidanceCounsellor_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: AdmissionsOfficer
CREATE TABLE AdmissionsOfficer (
    AdmissionsOfficerID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL UNIQUE,
    UniversityID INT NOT NULL,
    CONSTRAINT FK_AdmissionsOfficer_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: Checklist
CREATE TABLE Checklist (
    ChecklistID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    Description VARCHAR(200) NOT NULL,
    Status ENUM('Incomplete', 'Complete') NOT NULL,
    CONSTRAINT FK_Checklist_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);
-- Table: Application
CREATE TABLE Application (
    ApplicationID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    SubmissionDate VARCHAR(100),
    Status ENUM('Submitted', 'Accepted', 'Rejected') NOT NULL,
    GuidanceCounsellorID INT,
    AdmissionsOfficerID INT,
    FinancialAidID INT,
    FinancialInformationID INT,
    ChecklistID INT,
    DecisionID INT,
    CONSTRAINT FK_Application_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    CONSTRAINT FK_Application_GuidanceCounsellor FOREIGN KEY (GuidanceCounsellorID) REFERENCES GuidanceCounsellor(GuidanceCounsellorID),
    CONSTRAINT FK_Application_AdmissionsOfficer FOREIGN KEY (AdmissionsOfficerID) REFERENCES AdmissionsOfficer(AdmissionsOfficerID)
);


-- Table: Document
CREATE TABLE Document (
    DocumentID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    DocumentType VARCHAR(100) NOT NULL,
    UploadDate char,
    ChecklistID INT NOT NULL,
    CONSTRAINT FK_Document_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    CONSTRAINT FK_Document_Checklist FOREIGN KEY (ChecklistID) REFERENCES Checklist(ChecklistID)
);



-- Table: FinancialAid
CREATE TABLE FinancialAid (
    FinancialAidID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    Conditions VARCHAR(200),
    Amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_FinancialAid_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);

-- Table: Scholarship
CREATE TABLE Scholarship (
    ScholarshipID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Eligibility VARCHAR(200) NOT NULL,
    CONSTRAINT FK_Scholarship_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);

-- Table: Event
CREATE TABLE Event (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    Description VARCHAR(200) NOT NULL,
    EventDate VARCHAR(200)
);

-- Table: Decision
CREATE TABLE Decision (
    DecisionID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    Result ENUM('Accepted', 'Rejected', 'Waitlisted') NOT NULL,
    DecisionDate char,
    DecisionLetter VARCHAR(500),
    ContinuedInterest BOOLEAN DEFAULT FALSE,
    CONSTRAINT FK_Decision_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

-- Table: Contact
CREATE TABLE Contact (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    PhoneNumber VARCHAR(20),
    EmailAddress VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Contact_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: Survey
CREATE TABLE Survey (
    SurveyID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    SubmissionDate char,
    Feedback VARCHAR(500),
    CONSTRAINT FK_Survey_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);

-- Table: Deposit
CREATE TABLE Deposit (
    DepositID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    DatePaid char,
    CONSTRAINT FK_Deposit_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);
-- Table: FinancialInformation
CREATE TABLE FinancialInformation (
    FinancialInformationID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    EstimatedCost DECIMAL(10,2) NOT NULL,
    Taxes DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_FinancialInformation_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

-- Table: isApplicant
CREATE TABLE isApplicant (
    ApplicantID INT NOT NULL,
    PersonID INT NOT NULL,
    PRIMARY KEY (ApplicantID, PersonID),
    CONSTRAINT FK_isApplicant_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    CONSTRAINT FK_isApplicant_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: isGuidanceCounsellor
CREATE TABLE isGuidanceCounsellor (
    GuidanceCounsellorID INT NOT NULL,
    PersonID INT NOT NULL,
    PRIMARY KEY (GuidanceCounsellorID, PersonID),
    CONSTRAINT FK_isGuidanceCounsellor_GuidanceCounsellor FOREIGN KEY (GuidanceCounsellorID) REFERENCES GuidanceCounsellor(GuidanceCounsellorID),
    CONSTRAINT FK_isGuidanceCounsellor_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Table: AttendsEvents
CREATE TABLE AttendsEvents (
    ApplicantID INT NOT NULL,
    EventID INT NOT NULL,
    PRIMARY KEY (ApplicantID, EventID),
    CONSTRAINT FK_AttendsEvents_Applicant FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
    CONSTRAINT FK_AttendsEvents_Event FOREIGN KEY (EventID) REFERENCES Event(EventID)
);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (1, '17', 1);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (2, '39', 2);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (3, '9', 3);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (4, '7', 4);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (5, '37', 5);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (6, '33', 6);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (7, '46', 7);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (8, '21', 8);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (9, '10', 9);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (10, '36', 10);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (11, '42', 11);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (12, '1', 12);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (13, '44', 13);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (14, '43', 14);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (15, '32', 15);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (16, '19', 16);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (17, '31', 17);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (18, '4', 18);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (19, '45', 19);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (20, '34', 20);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (21, '15', 21);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (22, '6', 22);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (23, '50', 23);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (24, '28', 24);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (25, '13', 25);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (26, '18', 26);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (27, '27', 27);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (28, '14', 28);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (29, '12', 29);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (30, '16', 30);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (31, '49', 31);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (32, '24', 32);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (33, '11', 33);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (34, '48', 34);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (35, '23', 35);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (36, '8', 36);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (37, '47', 37);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (38, '5', 38);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (39, '20', 39);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (40, '38', 40);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (41, '25', 41);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (42, '26', 42);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (43, '41', 43);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (44, '22', 44);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (45, '40', 45);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (46, '2', 46);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (47, '29', 47);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (48, '35', 48);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (49, '3', 49);
insert into AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID) values (50, '30', 50);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (1, '16', 'Maplewood High School', 83104833, 873572631, 736138415);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (2, '3', 'Cedarwood High School', 974485178, 3500823, 682430238);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (3, '46', 'Willowbrook High School', 439736886, 576704446, 914425581);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (4, '45', 'Willowbrook High School', 348868759, 868927744, 780716572);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (5, '48', 'Maplewood High School', 313319503, 636754994, 523801099);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (6, '36', 'Sunset High School', 22033701, 240150228, 635428008);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (7, '4', 'Willowbrook High School', 643193448, 879445236, 744104711);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (8, '47', 'Maplewood High School', 931825195, 758439759, 603837689);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (9, '31', 'Oakwood High School', 144525836, 695998177, 589140487);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (10, '29', 'Riverdale High School', 551236486, 769958418, 348513096);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (11, '15', 'Sunset High School', 579143696, 5581, 559321498);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (12, '7', 'Riverdale High School', 293840872, 743127815, 835624205);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (13, '9', 'Pinecrest High School', 737655290, 9968700, 484029042);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (14, '25', 'Pinecrest High School', 811104064, 790209682, 887400694);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (15, '18', 'Oakwood High School', 533631595, 583804835, 465672466);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (16, '42', 'Willowbrook High School', 193036518, 100525793, 77101285);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (17, '26', 'Maplewood High School', 965149451, 196533780, 203049683);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (18, '17', 'Cedarwood High School', 357990055, 309234147, 113401806);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (19, '39', 'Springfield High School', 445537817, 81128090, 573006339);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (20, '34', 'Springfield High School', 768934776, 945864190, 658478097);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (21, '22', 'Springfield High School', 852923023, 840336388, 409542099);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (22, '24', 'Maplewood High School', 239135353, 93403504, 293492003);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (23, '11', 'Maplewood High School', 920466859, 749640685, 513339510);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (24, '10', 'Oakwood High School', 194600271, 111485581, 52840404);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (25, '49', 'Oakwood High School', 1283802, 730343270, 3311448);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (26, '28', 'Sunset High School', 684639520, 882771139, 31757529);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (27, '6', 'Cedarwood High School', 205812457, 145319541, 655947881);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (28, '40', 'Hillcrest High School', 569582140, 58264830, 87839481);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (29, '44', 'Cedarwood High School', 835562384, 604267898, 101311854);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (30, '37', 'Pinecrest High School', 398309564, 346027400, 747833811);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (31, '14', 'Riverdale High School', 923821731, 106596906, 40548635);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (32, '20', 'Meadowview High School', 677247774, 886270559, 148281759);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (33, '33', 'Maplewood High School', 646943557, 123985230, 640929649);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (34, '35', 'Pinecrest High School', 620986297, 852143151, 551890069);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (35, '2', 'Springfield High School', 871916749, 114903878, 919449975);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (36, '21', 'Cedarwood High School', 223177131, 147426151, 549728902);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (37, '23', 'Willowbrook High School', 550184198, 707625772, 744519508);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (38, '38', 'Willowbrook High School', 222680142, 588876667, 717398795);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (39, '43', 'Springfield High School', 220186898, 580096481, 172715157);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (40, '1', 'Cedarwood High School', 490994328, 475697974, 109405311);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (41, '50', 'Cedarwood High School', 843838495, 817835991, 872967790);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (42, '19', 'Oakwood High School', 796980143, 459484914, 986656732);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (43, '27', 'Hillcrest High School', 553218977, 649319716, 884311469);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (44, '8', 'Springfield High School', 810901070, 206513548, 381241886);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (45, '5', 'Sunset High School', 75789076, 869582839, 266870388);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (46, '30', 'Sunset High School', 688933077, 507034681, 40584804);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (47, '12', 'Sunset High School', 956187473, 870607516, 181379907);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (48, '32', 'Springfield High School', 359278053, 445337536, 813048943);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (49, '41', 'Pinecrest High School', 518602328, 924829667, 439645595);
# insert into Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) values (50, '13', 'Hillcrest High School', 793576733, 640776468, 546120990);
ALTER TABLE Event MODIFY COLUMN EventDate VARCHAR(255);
insert into Event (EventID, Description, EventDate) values (1, 'Alumni networking event for recent graduates', '10/13/2023 ');
insert into Event (EventID, Description, EventDate) values (2, 'College fair at local community center', '10/13/2023');
insert into Event (EventID, Description, EventDate) values (3, 'Application essay writing workshop', '4/25/2025');
insert into Event (EventID, Description, EventDate) values (4, 'Campus tour for incoming freshmen', '2/25/2025');
insert into Event (EventID, Description, EventDate) values (5, 'Virtual information session for prospective students', '7/11/2024');
insert into Event (EventID, Description, EventDate) values (6, 'Panel discussion with current college students', '11/10/2025');
insert into Event (EventID, Description, EventDate) values (7, 'Meet and greet with college faculty', '10/5/2024');
insert into Event (EventID, Description, EventDate) values (8, 'Meet and greet with college faculty', '3/19/2025');
insert into Event (EventID, Description, EventDate) values (9, 'Panel discussion with current college students', '7/6/2023');
insert into Event (EventID, Description, EventDate) values (10, 'Panel discussion with current college students', '9/25/2023');
insert into Event (EventID, Description, EventDate) values (11, 'Open house event for high school seniors', '5/13/2023');
insert into Event (EventID, Description, EventDate) values (12, 'College fair at local community center', '9/8/2023');
insert into Event (EventID, Description, EventDate) values (13, 'Open house event for high school seniors', '2/12/2024');
insert into Event (EventID, Description, EventDate) values (14, 'Application essay writing workshop', '6/19/2025');
insert into Event (EventID, Description, EventDate) values (15, 'Open house event for high school seniors', '2/11/2023');
insert into Event (EventID, Description, EventDate) values (16, 'Campus tour for incoming freshmen', '3/18/2023');
insert into Event (EventID, Description, EventDate) values (17, 'Financial aid information session', '4/30/2024');
insert into Event (EventID, Description, EventDate) values (18, 'Meet and greet with college faculty', '4/25/2023');
insert into Event (EventID, Description, EventDate) values (19, 'Application essay writing workshop', '9/1/2024');
insert into Event (EventID, Description, EventDate) values (20, 'Panel discussion with current college students', '7/9/2024');
insert into Event (EventID, Description, EventDate) values (21, 'Virtual information session for prospective students', '10/9/2023');
insert into Event (EventID, Description, EventDate) values (22, 'College fair at local community center', '4/6/2024');
insert into Event (EventID, Description, EventDate) values (23, 'Alumni networking event for recent graduates', '11/13/2025');
insert into Event (EventID, Description, EventDate) values (24, 'Admissions workshop for parents and students', '5/12/2024');
insert into Event (EventID, Description, EventDate) values (25, 'Campus tour for incoming freshmen', '5/18/2023');
insert into Event (EventID, Description, EventDate) values (26, 'Panel discussion with current college students', '4/3/2024');
insert into Event (EventID, Description, EventDate) values (27, 'College fair at local community center', '3/29/2024');
insert into Event (EventID, Description, EventDate) values (28, 'Application essay writing workshop', '11/7/2023');
insert into Event (EventID, Description, EventDate) values (29, 'Application essay writing workshop', '4/28/2023');
insert into Event (EventID, Description, EventDate) values (30, 'Campus tour for incoming freshmen', '10/12/2023');
insert into Event (EventID, Description, EventDate) values (31, 'Alumni networking event for recent graduates', '7/26/2023');
insert into Event (EventID, Description, EventDate) values (32, 'Open house event for high school seniors', '3/16/2023');
insert into Event (EventID, Description, EventDate) values (33, 'College fair at local community center', '3/14/2025');
insert into Event (EventID, Description, EventDate) values (34, 'Virtual information session for prospective students', '5/8/2023');
insert into Event (EventID, Description, EventDate) values (35, 'College fair at local community center', '1/18/2025');
insert into Event (EventID, Description, EventDate) values (36, 'Application essay writing workshop', '11/14/2025');
insert into Event (EventID, Description, EventDate) values (37, 'Financial aid information session', '7/26/2023');
insert into Event (EventID, Description, EventDate) values (38, 'Alumni networking event for recent graduates', '5/15/2025');
insert into Event (EventID, Description, EventDate) values (39, 'College fair at local community center', '12/29/2024');
insert into Event (EventID, Description, EventDate) values (40, 'Alumni networking event for recent graduates', '7/8/2023');
insert into Event (EventID, Description, EventDate) values (41, 'Alumni networking event for recent graduates', '9/3/2023');
insert into Event (EventID, Description, EventDate) values (42, 'Meet and greet with college faculty', '8/16/2023');
insert into Event (EventID, Description, EventDate) values (43, 'Campus tour for incoming freshmen', '11/5/2024');
insert into Event (EventID, Description, EventDate) values (44, 'Open house event for high school seniors', '1/3/2024');
insert into Event (EventID, Description, EventDate) values (45, 'Alumni networking event for recent graduates', '8/22/2023');
insert into Event (EventID, Description, EventDate) values (46, 'Panel discussion with current college students', '12/6/2025');
insert into Event (EventID, Description, EventDate) values (47, 'College fair at local community center', '7/14/2025');
insert into Event (EventID, Description, EventDate) values (48, 'Open house event for high school seniors', '9/9/2025');
insert into Event (EventID, Description, EventDate) values (49, 'Financial aid information session', '12/25/2023');
insert into Event (EventID, Description, EventDate) values (50, 'Alumni networking event for recent graduates', '12/3/2025');
insert into AttendsEvents (ApplicantID, EventID) values ('21', '36');
insert into AttendsEvents (ApplicantID, EventID) values ('25', '25');
insert into AttendsEvents (ApplicantID, EventID) values ('2', '1');
insert into AttendsEvents (ApplicantID, EventID) values ('17', '4');
insert into AttendsEvents (ApplicantID, EventID) values ('32', '43');
insert into AttendsEvents (ApplicantID, EventID) values ('50', '7');
insert into AttendsEvents (ApplicantID, EventID) values ('20', '12');
insert into AttendsEvents (ApplicantID, EventID) values ('14', '28');
insert into AttendsEvents (ApplicantID, EventID) values ('8', '29');
insert into AttendsEvents (ApplicantID, EventID) values ('19', '13');
insert into AttendsEvents (ApplicantID, EventID) values ('29', '27');
insert into AttendsEvents (ApplicantID, EventID) values ('13', '33');
insert into AttendsEvents (ApplicantID, EventID) values ('3', '2');
insert into AttendsEvents (ApplicantID, EventID) values ('26', '49');
insert into AttendsEvents (ApplicantID, EventID) values ('45', '48');
insert into AttendsEvents (ApplicantID, EventID) values ('6', '3');
insert into AttendsEvents (ApplicantID, EventID) values ('23', '22');
insert into AttendsEvents (ApplicantID, EventID) values ('43', '14');
insert into AttendsEvents (ApplicantID, EventID) values ('1', '10');
insert into AttendsEvents (ApplicantID, EventID) values ('39', '50');
insert into AttendsEvents (ApplicantID, EventID) values ('10', '5');
insert into AttendsEvents (ApplicantID, EventID) values ('48', '47');
insert into AttendsEvents (ApplicantID, EventID) values ('47', '46');
insert into AttendsEvents (ApplicantID, EventID) values ('30', '16');
insert into AttendsEvents (ApplicantID, EventID) values ('18', '11');
insert into AttendsEvents (ApplicantID, EventID) values ('44', '8');
insert into AttendsEvents (ApplicantID, EventID) values ('22', '40');
insert into AttendsEvents (ApplicantID, EventID) values ('42', '41');
insert into AttendsEvents (ApplicantID, EventID) values ('38', '6');
insert into AttendsEvents (ApplicantID, EventID) values ('9', '37');
insert into AttendsEvents (ApplicantID, EventID) values ('41', '35');
insert into AttendsEvents (ApplicantID, EventID) values ('28', '21');
insert into AttendsEvents (ApplicantID, EventID) values ('7', '20');
insert into AttendsEvents (ApplicantID, EventID) values ('11', '24');
insert into AttendsEvents (ApplicantID, EventID) values ('24', '30');
insert into AttendsEvents (ApplicantID, EventID) values ('34', '42');
insert into AttendsEvents (ApplicantID, EventID) values ('27', '15');
insert into AttendsEvents (ApplicantID, EventID) values ('40', '17');
insert into AttendsEvents (ApplicantID, EventID) values ('12', '23');
insert into AttendsEvents (ApplicantID, EventID) values ('15', '44');
insert into AttendsEvents (ApplicantID, EventID) values ('5', '39');
insert into AttendsEvents (ApplicantID, EventID) values ('16', '19');
insert into AttendsEvents (ApplicantID, EventID) values ('35', '38');
insert into AttendsEvents (ApplicantID, EventID) values ('37', '32');
insert into AttendsEvents (ApplicantID, EventID) values ('49', '26');
insert into AttendsEvents (ApplicantID, EventID) values ('4', '31');
insert into AttendsEvents (ApplicantID, EventID) values ('46', '34');
insert into AttendsEvents (ApplicantID, EventID) values ('33', '9');
insert into AttendsEvents (ApplicantID, EventID) values ('31', '18');
insert into AttendsEvents (ApplicantID, EventID) values ('36', '45');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (1, '50', '439-755-4890', 'kcorsan0@vistaprint.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (2, '18', '573-380-9783', 'wcaghy1@devhub.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (3, '44', '813-317-0295', 'nrookes2@thetimes.co.uk');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (4, '12', '368-340-2279', 'stooby3@list-manage.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (5, '30', '679-583-5339', 'sjandel4@imdb.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (6, '24', '873-830-0191', 'cschiementz5@twitpic.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (7, '33', '889-678-2587', 'ffarlane6@ucsd.edu');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (8, '20', '494-405-8232', 'kcamerati7@fastcompany.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (9, '14', '712-427-6666', 'docaine8@google.co.jp');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (10, '49', '947-160-7524', 'sroyal9@goo.gl');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (11, '46', '389-119-2293', 'arytona@trellian.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (12, '22', '933-344-0436', 'hskillingtonb@example.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (13, '41', '471-445-6229', 'tfidginc@tuttocitta.it');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (14, '9', '574-518-2089', 'gambrusd@ted.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (15, '36', '240-981-9494', 'snialse@oaic.gov.au');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (16, '13', '480-349-1801', 'chillettf@webs.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (17, '21', '261-291-5196', 'nhigbing@msn.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (18, '47', '356-460-3995', 'lwhartonbyh@wunderground.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (19, '6', '816-633-9595', 'gmccurlyei@google.ru');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (20, '3', '973-189-0368', 'dsnyderj@state.tx.us');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (21, '4', '754-590-5505', 'pstanluckk@google.it');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (22, '42', '715-979-7860', 'wkerblerl@usnews.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (23, '39', '768-100-7416', 'dtraffordm@google.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (24, '32', '397-366-9357', 'apercyn@163.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (25, '23', '153-539-0299', 'dcarlesso@spiegel.de');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (26, '26', '618-687-6689', 'dlampenp@howstuffworks.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (27, '34', '492-382-0624', 'bgurdonq@tinyurl.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (28, '37', '601-410-8494', 'lwoolagerr@gov.uk');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (29, '35', '610-420-0262', 'egilbarts@t.co');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (30, '25', '476-301-0308', 'sgateclifft@shop-pro.jp');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (31, '40', '415-595-7994', 'gbitcheneru@last.fm');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (32, '28', '238-865-5065', 'lmcnerlinv@delicious.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (33, '48', '448-106-5974', 'atrippittw@liveinternet.ru');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (34, '31', '738-698-6774', 'wdennickx@google.co.jp');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (35, '2', '499-359-5139', 'smckenneyy@ucla.edu');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (36, '10', '634-366-9695', 'pruddlez@netlog.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (37, '45', '121-592-5723', 'bshave10@amazon.co.uk');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (38, '43', '790-746-7953', 'sghent11@sbwire.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (39, '5', '162-247-4208', 'pkarleman12@trellian.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (40, '38', '467-189-0566', 'ltremathack13@hexun.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (41, '11', '608-104-5383', 'aallans14@com.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (42, '8', '550-317-5503', 'rrutty15@toplist.cz');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (43, '16', '835-307-4168', 'rantonazzi16@icq.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (44, '17', '656-688-8329', 'mvoaden17@skyrock.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (45, '19', '347-533-5253', 'bzipsell18@yolasite.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (46, '1', '841-444-6399', 'wlafflin19@deviantart.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (47, '29', '474-121-6959', 'astarkie1a@nasa.gov');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (48, '27', '369-595-0560', 'jsinson1b@gmpg.org');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (49, '15', '487-730-7543', 'nfanner1c@gravatar.com');
insert into Contact (ContactID, PersonID, PhoneNumber, EmailAddress) values (50, '7', '951-147-1721', 'iknevett1d@timesonline.co.uk');
ALTER TABLE Deposit MODIFY COLUMN DatePaid VARCHAR(255);
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (1, '12', 90000, '4/26/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (2, '42', 100000, '1/26/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (3, '18', 40000, '9/16/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (4, '37', 20000, '2/16/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (5, '27', 90000, '2/2/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (6, '32', 90000, '8/4/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (7, '30', 60000, '1/30/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (8, '17', 10000, '4/30/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (9, '24', 20000, '12/15/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (10, '7', 10000, '3/6/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (11, '35', 50000, '9/9/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (12, '25', 90000, '12/3/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (13, '31', 70000, '3/19/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (14, '28', 60000, '4/4/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (15, '8', 60000, '12/29/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (16, '22', 90000, '4/29/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (17, '33', 100000, '2/5/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (18, '48', 90000, '11/2/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (19, '13', 100000, '12/7/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (20, '26', 30000, '4/12/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (21, '1', 20000, '7/8/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (22, '34', 50000, '3/4/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (23, '10', 10000, '1/18/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (24, '15', 30000, '5/2/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (25, '46', 100000, '8/6/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (26, '44', 60000, '11/26/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (27, '5', 20000, '7/6/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (28, '39', 60000, '11/23/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (29, '3', 40000, '3/17/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (30, '4', 40000, '8/19/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (31, '38', 30000, '11/17/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (32, '29', 30000, '9/29/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (33, '47', 50000, '7/5/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (34, '41', 30000, '6/28/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (35, '11', 50000, '6/26/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (36, '40', 80000, '5/6/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (37, '14', 10000, '7/9/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (38, '23', 30000, '11/11/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (39, '16', 50000, '10/14/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (40, '43', 80000, '5/12/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (41, '2', 50000, '10/31/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (42, '20', 30000, '9/3/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (43, '45', 40000, '1/27/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (44, '19', 50000, '7/1/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (45, '50', 30000, '11/25/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (46, '6', 70000, '3/26/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (47, '21', 10000, '3/30/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (48, '49', 20000, '10/10/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (49, '36', 100000, '6/26/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (50, '9', 40000, '11/22/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (51, '10', 90000, '5/13/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (52, '20', 80000, '10/10/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (53, '12', 20000, '2/12/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (54, '7', 40000, '11/15/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (55, '18', 90000, '4/26/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (56, '25', 60000, '4/1/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (57, '36', 50000, '7/29/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (58, '46', 10000, '9/12/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (59, '49', 50000, '1/30/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (60, '17', 50000, '8/10/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (61, '16', 30000, '12/28/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (62, '2', 70000, '8/24/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (63, '4', 100000, '9/25/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (64, '23', 80000, '12/29/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (65, '15', 30000, '12/11/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (66, '24', 50000, '12/1/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (67, '38', 20000, '9/14/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (68, '19', 50000, '7/7/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (69, '31', 30000, '4/26/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (70, '28', 70000, '4/4/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (71, '3', 10000, '6/27/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (72, '21', 20000, '4/21/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (73, '41', 10000, '12/9/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (74, '27', 70000, '11/6/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (75, '1', 90000, '10/11/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (76, '14', 80000, '3/29/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (77, '44', 90000, '8/2/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (78, '48', 70000, '12/31/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (79, '32', 100000, '7/29/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (80, '30', 60000, '7/18/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (81, '35', 20000, '6/12/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (82, '39', 20000, '8/7/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (83, '9', 90000, '5/4/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (84, '45', 70000, '1/13/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (85, '11', 50000, '10/7/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (86, '26', 10000, '1/15/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (87, '42', 40000, '12/8/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (88, '50', 60000, '12/15/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (89, '33', 20000, '8/20/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (90, '40', 60000, '4/1/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (91, '47', 20000, '10/21/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (92, '29', 90000, '1/14/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (93, '5', 20000, '3/11/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (94, '34', 40000, '9/18/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (95, '6', 20000, '6/25/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (96, '13', 100000, '7/11/2024');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (97, '22', 20000, '8/20/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (98, '37', 100000, '8/12/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (99, '43', 100000, '10/29/2025');
insert into Deposit (DepositID, ApplicantID, Amount, DatePaid) values (100, '8', 20000, '7/20/2025');


insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (1, '32', 'Essay or personal statement', 839956.13);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (2, '3', 'Participation in extracurricular activities', 371501.91);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (3, '5', 'Participation in extracurricular activities', 990415.17);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (4, '20', 'Proof of income below a certain threshold', 364775.56);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (5, '25', 'Participation in extracurricular activities', 719617.73);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (6, '24', 'First-generation college student', 702294.45);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (7, '33', 'First-generation college student', 498681.66);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (8, '28', 'Community service involvement', 828036.87);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (9, '18', 'Essay or personal statement', 205631.23);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (10, '34', 'Community service involvement', 731659.39);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (11, '43', 'Proof of income below a certain threshold', 466871.27);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (12, '41', 'Minority status', 231336.14);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (13, '49', 'Minority status', 322892.26);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (14, '35', 'Submission of FAFSA form', 606010.72);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (15, '39', 'Academic merit', 473697.81);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (16, '22', 'Submission of FAFSA form', 902965.12);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (17, '1', 'Minority status', 313043.5);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (18, '23', 'Demonstrated financial need', 418717.46);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (19, '2', 'Community service involvement', 544095.94);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (20, '26', 'Minority status', 646171.17);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (21, '31', 'First-generation college student', 728387.26);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (22, '12', 'Enrollment in specific program or major', 149602.45);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (23, '29', 'Community service involvement', 203571.1);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (24, '36', 'Submission of FAFSA form', 739787.6);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (25, '44', 'Minority status', 599167.61);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (26, '48', 'Demonstrated financial need', 88390.93);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (27, '13', 'Submission of FAFSA form', 100446.29);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (28, '19', 'Academic merit', 707244.3);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (29, '46', 'Academic merit', 675753.69);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (30, '45', 'Demonstrated financial need', 141003.43);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (31, '9', 'Proof of income below a certain threshold', 719985.08);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (32, '4', 'Essay or personal statement', 961169.23);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (33, '38', 'Proof of income below a certain threshold', 278559.32);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (34, '8', 'Enrollment in specific program or major', 847981.24);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (35, '7', 'Essay or personal statement', 723439.06);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (36, '6', 'Enrollment in specific program or major', 940680.31);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (37, '17', 'Proof of income below a certain threshold', 731799.1);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (38, '30', 'Academic merit', 640641.96);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (39, '42', 'Essay or personal statement', 875645.72);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (40, '27', 'First-generation college student', 56183.06);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (41, '47', 'Essay or personal statement', 419530.45);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (42, '10', 'Academic merit', 413412.95);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (43, '37', 'Minority status', 382590.49);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (44, '14', 'Demonstrated financial need', 727202.14);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (45, '11', 'First-generation college student', 660306.04);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (46, '40', 'Community service involvement', 453348.1);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (47, '50', 'Essay or personal statement', 866132.62);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (48, '15', 'Community service involvement', 299844.98);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (49, '21', 'Submission of FAFSA form', 448040.42);
insert into FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount) values (50, '16', 'Proof of income below a certain threshold', 579983.25);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (1, '38', 32000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (2, '26', 75000, 5600);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (3, '48', 60000, 3800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (4, '44', 67000, 3000);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (5, '46', 90000, 4200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (6, '42', 60000, 9100);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (7, '15', 75000, 5000);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (8, '23', 32000, 4800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (9, '19', 48000, 4200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (10, '25', 32000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (11, '43', 60000, 7500);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (12, '16', 50000, 3800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (13, '33', 48000, 3800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (14, '40', 48000, 9100);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (15, '39', 60000, 8200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (16, '24', 48000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (17, '45', 58000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (18, '11', 67000, 4800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (19, '7', 90000, 8200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (20, '29', 42000, 9100);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (21, '32', 53000, 7500);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (22, '20', 75000, 9100);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (23, '18', 42000, 5600);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (24, '17', 50000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (25, '41', 42000, 3000);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (26, '31', 58000, 7500);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (27, '8', 58000, 8200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (28, '6', 48000, 4200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (29, '13', 53000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (30, '37', 32000, 5600);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (31, '12', 53000, 7500);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (32, '21', 67000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (33, '14', 53000, 9100);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (34, '35', 67000, 4200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (35, '9', 90000, 5000);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (36, '28', 60000, 4800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (37, '2', 60000, 4800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (38, '4', 90000, 4200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (39, '36', 32000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (40, '47', 32000, 4800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (41, '5', 32000, 4800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (42, '1', 58000, 7500);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (43, '49', 75000, 9100);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (44, '10', 53000, 7500);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (45, '50', 90000, 4200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (46, '3', 58000, 3800);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (47, '22', 67000, 6400);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (48, '30', 32000, 5600);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (49, '27', 32000, 8200);
insert into FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes) values (50, '34', 67000, 5600);
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (952986776, '25', '#1c4');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (97876631, '6', '#181');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (958870349, '38', '#ea0');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (366579849, '7', '#bbd');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (78603104, '13', '#d6f');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1825353002, '39', '#30f');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (2016599240, '49', '#c0f');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (477056948, '46', '#7a7');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (998214020, '15', '#3fb');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (328663121, '31', '#88e');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1328268470, '14', '#db4');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (510508050, '48', '#fe3');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1574018510, '22', '#38e');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1315299638, '3', '#dff');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (2119531340, '33', '#9f1');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1656395519, '43', '#71b');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (146054873, '17', '#30f');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1194653715, '24', '#d5a');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (192082363, '45', '#854');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (573337923, '32', '#153');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (83369086, '9', '#9a4');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1144340443, '19', '#d82');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (2055134887, '11', '#25d');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (793204091, '40', '#337');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (997635017, '18', '#456');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (2095614540, '23', '#416');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1478712401, '42', '#cd0');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1330940082, '21', '#1c7');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (226682711, '5', '#762');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (417294516, '37', '#5bd');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1467396585, '30', '#0d9');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (315967218, '34', '#670');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1722889339, '44', '#bc9');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1513892531, '41', '#7d7');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1390242866, '28', '#f78');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1231128862, '12', '#c13');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1504944779, '27', '#e06');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (438012682, '26', '#f02');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1752183295, '8', '#aef');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1524935916, '36', '#9b2');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1573831335, '20', '#5b0');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (775003734, '29', '#c71');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1423018523, '50', '#dcc');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1086809687, '47', '#525');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1838435584, '16', '#5cc');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (503783847, '10', '#fa6');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1399003955, '1', '#6ed');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (38623875, '4', '#212');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (1783235861, '35', '#c2d');
insert into GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool) values (721926986, '2', '#1e3');
insert into isApplicant (ApplicantID, PersonID) values ('6', '1');
insert into isApplicant (ApplicantID, PersonID) values ('12', '38');
insert into isApplicant (ApplicantID, PersonID) values ('22', '3');
insert into isApplicant (ApplicantID, PersonID) values ('39', '41');
insert into isApplicant (ApplicantID, PersonID) values ('3', '42');
insert into isApplicant (ApplicantID, PersonID) values ('11', '5');
insert into isApplicant (ApplicantID, PersonID) values ('28', '2');
insert into isApplicant (ApplicantID, PersonID) values ('35', '22');
insert into isApplicant (ApplicantID, PersonID) values ('30', '13');
insert into isApplicant (ApplicantID, PersonID) values ('21', '12');
insert into isApplicant (ApplicantID, PersonID) values ('34', '18');
insert into isApplicant (ApplicantID, PersonID) values ('2', '29');
insert into isApplicant (ApplicantID, PersonID) values ('29', '37');
insert into isApplicant (ApplicantID, PersonID) values ('31', '48');
insert into isApplicant (ApplicantID, PersonID) values ('32', '33');
insert into isApplicant (ApplicantID, PersonID) values ('43', '8');
insert into isApplicant (ApplicantID, PersonID) values ('44', '15');
insert into isApplicant (ApplicantID, PersonID) values ('37', '10');
insert into isApplicant (ApplicantID, PersonID) values ('50', '6');
insert into isApplicant (ApplicantID, PersonID) values ('8', '45');
insert into isApplicant (ApplicantID, PersonID) values ('46', '25');
insert into isApplicant (ApplicantID, PersonID) values ('26', '27');
insert into isApplicant (ApplicantID, PersonID) values ('23', '20');
insert into isApplicant (ApplicantID, PersonID) values ('15', '30');
insert into isApplicant (ApplicantID, PersonID) values ('41', '21');
insert into isApplicant (ApplicantID, PersonID) values ('19', '36');
insert into isApplicant (ApplicantID, PersonID) values ('1', '11');
insert into isApplicant (ApplicantID, PersonID) values ('25', '19');
insert into isApplicant (ApplicantID, PersonID) values ('48', '9');
insert into isApplicant (ApplicantID, PersonID) values ('9', '7');
insert into isApplicant (ApplicantID, PersonID) values ('24', '23');
insert into isApplicant (ApplicantID, PersonID) values ('42', '24');
insert into isApplicant (ApplicantID, PersonID) values ('5', '46');
insert into isApplicant (ApplicantID, PersonID) values ('18', '28');
insert into isApplicant (ApplicantID, PersonID) values ('47', '32');
insert into isApplicant (ApplicantID, PersonID) values ('38', '35');
insert into isApplicant (ApplicantID, PersonID) values ('40', '40');
insert into isApplicant (ApplicantID, PersonID) values ('33', '26');
insert into isApplicant (ApplicantID, PersonID) values ('4', '44');
insert into isApplicant (ApplicantID, PersonID) values ('20', '4');
insert into isApplicant (ApplicantID, PersonID) values ('10', '43');
insert into isApplicant (ApplicantID, PersonID) values ('36', '34');
insert into isApplicant (ApplicantID, PersonID) values ('49', '47');
insert into isApplicant (ApplicantID, PersonID) values ('45', '50');
insert into isApplicant (ApplicantID, PersonID) values ('16', '31');
insert into isApplicant (ApplicantID, PersonID) values ('13', '14');
insert into isApplicant (ApplicantID, PersonID) values ('14', '39');
insert into isApplicant (ApplicantID, PersonID) values ('27', '16');
insert into isApplicant (ApplicantID, PersonID) values ('7', '17');
insert into isApplicant (ApplicantID, PersonID) values ('17', '49');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('565878348', '2');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('2091129208', '19');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('564601112', '26');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('996593668', '48');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1910236217', '11');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('371421244', '1');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('482975308', '24');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1053487951', '31');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('7869449', '15');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('628290860', '17');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('729337753', '40');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('30358770', '7');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('300836671', '46');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('37284891', '47');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('2042914671', '28');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('17384849', '21');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1568006923', '33');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('870737936', '37');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1862952405', '43');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1195470701', '35');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1806907873', '36');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1951664230', '45');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1975728602', '29');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1792569796', '13');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('585825655', '32');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('753309918', '5');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('278613721', '34');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('575126074', '18');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('596340223', '9');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1676366997', '22');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('141463877', '41');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1752821892', '3');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1117198452', '25');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1996662616', '10');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('686987445', '16');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1219581487', '12');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('754975483', '44');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1804943624', '39');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1504299267', '6');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('436360375', '50');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('2048022662', '42');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('641705766', '27');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1056181021', '4');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1715404729', '14');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1668146506', '8');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('781404917', '20');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1188280096', '38');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1309518939', '23');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('1982170055', '30');
insert into isGuidanceCounsellor (GuidanceCounsellorID, PersonID) values ('106009575', '49');
ALTER TABLE Person Modify column DOB VARCHAR(225);
insert into Person (PersonID, Name, DOB, Type) values (1, 'Aida', '12/1/1908', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (2, 'Hermie', '11/15/1970', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (3, 'Casey', '1/3/1978', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (4, 'Sydel', '7/13/1940', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (5, 'Anita', '1/16/1964', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (6, 'Ross', '6/26/1997', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (7, 'Wynn', '9/27/1994', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (8, 'Marcelo', '9/17/1963', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (9, 'Simone', '8/27/1908', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (10, 'Yance', '2/18/1986', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (11, 'Silvano', '11/12/1961', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (12, 'Shelly', '11/25/1957', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (13, 'Somerset', '4/30/1974', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (14, 'Boone', '1/7/1931', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (15, 'Cynde', '10/17/1995', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (16, 'Tildy', '11/30/1913', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (17, 'Claudell', '5/15/1947', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (18, 'Odilia', '12/30/2019', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (19, 'Francesco', '10/3/1937', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (20, 'Ivie', '3/11/1910', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (21, 'Daphne', '3/10/1951', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (22, 'Jennifer', '11/10/1985', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (23, 'Hildy', '3/19/1986', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (24, 'Cornelle', '7/25/1941', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (25, 'Theresita', '12/19/1964', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (26, 'Rana', '2/26/1937', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (27, 'Ted', '11/24/1968', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (28, 'Dayle', '5/10/1976', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (29, 'Mindy', '10/5/2019', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (30, 'Myrwyn', '1/6/1963', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (31, 'Hazlett', '9/30/2005', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (32, 'Leta', '6/15/2011', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (33, 'Rodolfo', '10/15/1961', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (34, 'Lacy', '1/7/1985', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (35, 'Ines', '12/18/1908', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (36, 'Franklyn', '4/18/2019', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (37, 'Elwood', '8/21/1980', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (38, 'Christy', '10/15/1947', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (39, 'Shurlocke', '5/16/1919', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (40, 'Mordecai', '4/25/1903', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (41, 'West', '9/7/2009', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (42, 'Edeline', '12/14/1962', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (43, 'Luce', '2/14/2008', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (44, 'Dougie', '4/26/1989', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (45, 'Horton', '1/22/1995', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (46, 'Peterus', '11/27/1958', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (47, 'Benedetto', '1/23/1947', 'Applicant');
insert into Person (PersonID, Name, DOB, Type) values (48, 'Farris', '1/5/1964', 'Guidance Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (49, 'Emilio', '9/21/1965', 'Admissions Counsellor');
insert into Person (PersonID, Name, DOB, Type) values (50, 'Constancia', '11/17/1987', 'Admissions Counsellor');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (1, '46', 'Academic Excellence Scholarship', 70000, 'Participation in a leadership program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (2, '27', 'Innovation and Technology Scholarship', 30000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (3, '14', 'Environmental Sustainability Scholarship', 35000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (4, '39', 'Environmental Sustainability Scholarship', 30000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (5, '47', 'Health and Wellness Scholarship', 70000, 'Essay submission');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (6, '31', 'Creative Arts Scholarship', 45000, 'Participation in a leadership program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (7, '9', 'Health and Wellness Scholarship', 10000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (8, '42', 'Entrepreneurship Scholarship', 35000, 'Participation in community service activities');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (9, '20', 'Entrepreneurship Scholarship', 80000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (10, '16', 'Innovation and Technology Scholarship', 35000, 'Member of a minority group');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (11, '28', 'Community Service Scholarship', 35000, 'Participation in a leadership program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (12, '24', 'Health and Wellness Scholarship', 75000, 'Enrolled in a STEM program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (13, '34', 'Health and Wellness Scholarship', 35000, 'GPA of 3.5 or higher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (14, '38', 'Creative Arts Scholarship', 80000, 'GPA of 3.5 or higher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (15, '25', 'Innovation and Technology Scholarship', 75000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (16, '37', 'Diversity and Inclusion Scholarship', 35000, 'Recommendation letter from a teacher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (17, '1', 'Academic Excellence Scholarship', 60000, 'Essay submission');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (18, '8', 'Academic Excellence Scholarship', 45000, 'Demonstrated financial need');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (19, '36', 'Entrepreneurship Scholarship', 75000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (20, '18', 'Entrepreneurship Scholarship', 50000, 'Recommendation letter from a teacher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (21, '5', 'Diversity and Inclusion Scholarship', 10000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (22, '13', 'Diversity and Inclusion Scholarship', 45000, 'GPA of 3.5 or higher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (23, '49', 'Innovation and Technology Scholarship', 50000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (24, '26', 'Future Leaders Scholarship', 75000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (25, '40', 'Academic Excellence Scholarship', 80000, 'Member of a minority group');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (26, '29', 'Health and Wellness Scholarship', 10000, 'Enrolled in a STEM program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (27, '10', 'Innovation and Technology Scholarship', 30000, 'Demonstrated financial need');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (28, '50', 'Environmental Sustainability Scholarship', 10000, 'Recommendation letter from a teacher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (29, '32', 'Diversity and Inclusion Scholarship', 70000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (30, '43', 'Community Service Scholarship', 30000, 'Minimum of 50 hours of volunteer work');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (31, '11', 'Diversity and Inclusion Scholarship', 45000, 'Demonstrated financial need');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (32, '2', 'Diversity and Inclusion Scholarship', 80000, 'GPA of 3.5 or higher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (33, '15', 'Diversity and Inclusion Scholarship', 10000, 'Demonstrated financial need');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (34, '6', 'Global Citizenship Scholarship', 10000, 'Participation in a leadership program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (35, '12', 'Future Leaders Scholarship', 75000, 'Essay submission');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (36, '44', 'Global Citizenship Scholarship', 80000, 'GPA of 3.5 or higher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (37, '17', 'Future Leaders Scholarship', 70000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (38, '7', 'Diversity and Inclusion Scholarship', 60000, 'Participation in community service activities');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (39, '3', 'Academic Excellence Scholarship', 35000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (40, '19', 'Community Service Scholarship', 45000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (41, '23', 'Academic Excellence Scholarship', 70000, 'Demonstrated financial need');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (42, '48', 'Global Citizenship Scholarship', 25000, 'Enrolled in a STEM program');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (43, '21', 'Future Leaders Scholarship', 35000, 'Essay submission');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (44, '30', 'Health and Wellness Scholarship', 10000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (45, '41', 'Future Leaders Scholarship', 35000, 'Member of a minority group');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (46, '22', 'Creative Arts Scholarship', 80000, 'Participation in community service activities');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (47, '45', 'Entrepreneurship Scholarship', 70000, 'Recommendation letter from a teacher');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (48, '35', 'Creative Arts Scholarship', 35000, 'Participation in community service activities');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (49, '33', 'Creative Arts Scholarship', 50000, 'Interest in pursuing a career in healthcare');
insert into Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) values (50, '4', 'Innovation and Technology Scholarship', 70000, 'Essay submission');
ALTER TABLE Survey MODIFY COLUMN SubmissionDate VARCHAR(255);
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (1, '20', '1/18/2024', 'Could use more clarity on the program requirements.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (2, '40', '8/24/2024', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (3, '14', '12/1/2024', 'a positive experience with the admissions team.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (4, '17', '9/11/2025', 'Great communication throughout the process.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (5, '46', '5/28/2025', 'Appreciate the prompt responses to my inquiries.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (6, '45', '7/9/2025', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (7, '35', '12/21/2025', 'Appreciate the prompt responses to my inquiries.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (8, '23', '2/25/2025', 'thank you!');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (9, '50', '12/7/2024', 'Great communication throughout the process.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (10, '31', '4/22/2024', 'Appreciate the prompt responses to my inquiries.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (11, '16', '11/13/2025', 'Thank you for the opportunity to interview for the program.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (12, '37', '3/13/2025', 'Appreciate the prompt responses to my inquiries.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (13, '4', '4/22/2025', 'Very informative presentation');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (14, '47', '9/24/2025', 'Could use more clarity on the program requirements.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (15, '9', '2/13/2025', 'Looking forward to starting my studies at the university.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (16, '48', '8/25/2025', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (17, '44', '6/9/2024', 'Overall');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (18, '49', '9/21/2025', 'Thank you for the opportunity to interview for the program.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (19, '33', '11/12/2025', 'Found the application process to be straightforward.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (20, '25', '5/26/2025', 'Found the application process to be straightforward.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (21, '34', '2/5/2024', 'Very informative presentation');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (22, '2', '11/28/2024', 'Could use more clarity on the program requirements.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (23, '27', '2/10/2025', 'Very informative presentation');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (24, '24', '10/18/2025', 'Looking forward to starting my studies at the university.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (25, '6', '5/31/2024', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (26, '5', '11/22/2024', 'Looking forward to starting my studies at the university.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (27, '39', '5/16/2024', 'Appreciate the prompt responses to my inquiries.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (28, '3', '11/7/2025', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (29, '10', '3/13/2025', 'a positive experience with the admissions team.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (30, '32', '7/28/2024', 'a positive experience with the admissions team.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (31, '15', '5/24/2025', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (32, '19', '12/1/2024', 'Would like to see more diversity in the student body.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (33, '26', '11/18/2025', 'Could use more clarity on the program requirements.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (34, '29', '2/18/2024', 'a positive experience with the admissions team.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (35, '21', '10/1/2025', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (36, '18', '9/8/2024', 'Could use more clarity on the program requirements.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (37, '1', '10/13/2024', 'a positive experience with the admissions team.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (38, '30', '12/2/2024', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (39, '7', '6/9/2024', 'Looking forward to starting my studies at the university.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (40, '36', '3/18/2025', 'Great communication throughout the process.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (41, '22', '9/8/2025', 'Overall');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (42, '43', '7/9/2024', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (43, '41', '1/7/2025', 'Would like to see more diversity in the student body.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (44, '28', '6/7/2025', 'Thank you for the opportunity to interview for the program.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (45, '13', '5/11/2025', 'Great communication throughout the process.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (46, '38', '10/31/2024', 'Overall');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (47, '8', '5/12/2025', 'Great communication throughout the process.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (48, '42', '10/22/2024', 'Impressed with the level of professionalism.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (49, '11', '7/19/2024', 'Could use more clarity on the program requirements.');
insert into Survey (SurveyID, ApplicantID, SubmissionDate, Feedback) values (50, '12', '8/17/2025', 'Thank you for the opportunity to interview for the program.');
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (1, '4', ' ', 'Rejected', '1668146506', '2042914671', 1, 1, 1, 1);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (2, '6', '11/10/2012', 'Accepted', '17384849', '1117198452', 2, 2, 2, 2);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (3, '7', '8/2/2002', 'Accepted', '641705766', '7869449', 3, 3, 3, 3);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (4, '27', '6/9/2021', 'Rejected', '628290860', '585825655', 4, 4, 4, 4);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (5, '16', '10/31/2014', 'Accepted', '1715404729', '575126074', 5, 5, 5, 5);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (6, '8', '3/25/2022', 'Accepted', '1752821892', '1982170055', 6, 6, 6, 6);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (7, '31', '11/13/2004', 'Rejected', '1504299267', '106009575', 7, 7, 7, 7);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (8, '34', '11/30/2012', 'Accepted', '37284891', '278613721', 8, 8, 8, 8);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (9, '36', '8/4/2008', 'Rejected', '754975483', '1806907873', 9, 9, 9, 9);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (10, '30', '7/12/2015', 'Accepted', '1056181021', '2091129208', 10, 10, 10, 10);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (11, '20', '3/7/2004', 'Accepted', '1910236217', '1053487951', 11, 11, 11, 11);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (12, '26', '1/31/2009', 'Submitted', '686987445', '1504299267', 12, 12, 12, 12);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (13, '1', '7/20/2004', 'Accepted', '1676366997', '1752821892', 13, 13, 13, 13);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (14, '50', '2/11/2018', 'Accepted', '278613721', '641705766', 14, 14, 14, 14);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (15, '42', '2/17/2008', 'Submitted', '300836671', '564601112', 15, 15, 15, 15);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (16, '12', '8/16/2013', 'Rejected', '106009575', '1219581487', 16, 16, 16, 16);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (17, '14', '8/23/2021', 'Accepted', '2042914671', '436360375', 17, 17, 17, 17);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (18, '39', '7/24/2021', 'Accepted', '141463877', '300836671', 18, 18, 18, 18);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (19, '29', '3/1/2010', 'Rejected', '585825655', '729337753', 19, 19, 19, 19);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (20, '25', '1/23/2007', 'Submitted', '565878348', '1309518939', 20, 20, 20, 20);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (21, '49', '3/12/2020', 'Accepted', '30358770', '482975308', 21, 21, 21, 21);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (22, '24', '12/8/2004', 'Submitted', '781404917', '37284891', 22, 22, 22, 22);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (23, '5', '6/30/2012', 'Rejected', '2091129208', '371421244', 23, 23, 23, 23);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (24, '48', '11/21/2005', 'Rejected', '1806907873', '1910236217', 24, 24, 24, 24);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (25, '11', '2/5/2001', 'Accepted', '1982170055', '30358770', 25, 25, 25, 25);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (26, '38', '11/5/2010', 'Rejected', '1862952405', '1715404729', 26, 26, 26, 26);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (27, '41', '6/30/2020', 'Rejected', '2048022662', '141463877', 27, 27, 27, 27);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (28, '32', '8/4/2020', 'Accepted', '1188280096', '1195470701', 28, 28, 28, 28);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (29, '45', '1/18/2017', 'Rejected', '1996662616', '1676366997', 29, 29, 29, 29);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (30, '9', '3/10/2004', 'Rejected', '870737936', '1975728602', 30, 30, 30, 30);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (31, '13', '2/13/2003', 'Accepted', '1195470701', '565878348', 31, 31, 31, 31);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (32, '28', '8/21/2000', 'Rejected', '482975308', '870737936', 32, 32, 32, 32);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (33, '2', '8/16/2007', 'Rejected', '575126074', '1792569796', 33, 33, 33, 33);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (34, '40', '9/30/2016', 'Rejected', '371421244', '1951664230', 34, 34, 34, 34);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (35, '23', '2/13/2015', 'Rejected', '753309918', '996593668', 35, 35, 35, 35);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (36, '46', '6/5/2003', 'Rejected', '564601112', '1568006923', 36, 36, 36, 36);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (37, '17', '2/7/2018', 'Accepted', '1975728602', '1862952405', 37, 37, 37, 37);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (38, '35', '9/12/2017', 'Accepted', '1792569796', '1056181021', 38, 38, 38, 38);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (39, '21', '1/4/2009', 'Accepted', '436360375', '1804943624', 39, 39, 39, 39);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (40, '33', '5/29/2004', 'Rejected', '1053487951', '1668146506', 40, 40, 40, 40);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (41, '10', '11/12/2014', 'Accepted', '1951664230', '753309918', 41, 41, 41, 41);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (42, '22', '7/23/2011', 'Rejected', '1309518939', '1188280096', 42, 42, 42, 42);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (43, '47', '7/15/2012', 'Rejected', '1117198452', '1996662616', 43, 43, 43, 43);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (44, '18', '10/12/2001', 'Rejected', '1804943624', '17384849', 44, 44, 44, 44);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (45, '15', '11/4/2008', 'Rejected', '596340223', '754975483', 45, 45, 45, 45);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (46, '43', '10/31/2011', 'Submitted', '729337753', '686987445', 46, 46, 46, 46);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (47, '44', '7/24/2001', 'Submitted', '1568006923', '596340223', 47, 47, 47, 47);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (48, '37', '11/10/2013', 'Rejected', '1219581487', '781404917', 48, 48, 48, 48);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (49, '19', '6/20/2004', 'Accepted', '996593668', '628290860', 49, 49, 49, 49);
insert into Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, AdmissionsOfficerID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) values (50, '3', '3/13/2002', 'Submitted', '7869449', '2048022662', 50, 50, 50, 50);
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (1, '13', 'mi sit amet lobortis sapien sapien non mi integer ac', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (2, '19', 'donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (3, '41', 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (4, '29', 'id consequat in consequat ut nulla sed accumsan felis ut at', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (5, '34', 'nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (6, '23', 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (7, '50', 'aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (8, '27', 'et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (9, '15', 'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (10, '31', 'consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (11, '37', 'tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (12, '17', 'tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (13, '33', 'ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (14, '8', 'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (15, '36', 'in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (16, '21', 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (17, '9', 'vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (18, '25', 'libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (19, '40', 'consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (20, '42', 'eget eleifend luctus ultricies eu nibh quisque id justo sit amet', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (21, '16', 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (22, '49', 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (23, '30', 'non mauris morbi non lectus aliquam sit amet diam in magna', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (24, '22', 'maecenas tincidunt lacus at velit vivamus vel nulla eget eros', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (25, '10', 'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (26, '6', 'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (27, '20', 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (28, '35', 'rutrum neque aenean auctor gravida sem praesent id massa id', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (29, '32', 'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (30, '39', 'molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (31, '38', 'integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (32, '11', 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (33, '7', 'curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (34, '14', 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (35, '44', 'aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (36, '12', 'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (37, '47', 'in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (38, '46', 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (39, '4', 'eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (40, '45', 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (41, '26', 'id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (42, '28', 'ultrices posuere cubilia curae nulla dapibus dolor vel est donec', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (43, '1', 'nam dui proin leo odio porttitor id consequat in consequat ut nulla', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (44, '5', 'pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (45, '2', 'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (46, '18', 'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (47, '48', 'hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (48, '43', 'amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante', 'Complete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (49, '24', 'dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non', 'Incomplete');
insert into Checklist (ChecklistID, ApplicationID, Description, Status) values (50, '3', 'malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem', 'Complete');

insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (1, '6', 'Letter of recommendation', '5/10/2007', '33');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (2, '40', 'Personal statement', '9/27/2005', '26');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (3, '8', 'Personal statement', '9/14/2020', '28');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (4, '31', 'Personal statement', '8/31/2018', '49');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (5, '37', 'Proof of English proficiency', '8/14/2009', '45');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (6, '43', 'Letter of recommendation', '8/29/2020', '18');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (7, '22', 'Proof of vaccination', '4/13/2005', '41');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (8, '35', 'Proof of English proficiency', '9/7/2009', '47');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (9, '28', 'Resume', '7/11/2001', '13');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (10, '30', 'Proof of English proficiency', '5/30/2008', '1');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (11, '27', 'Personal statement', '3/27/2011', '7');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (12, '50', 'Medical history form', '7/26/2008', '40');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (13, '20', 'Essay', '11/14/2006', '2');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (14, '17', 'Essay', '4/13/2005', '10');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (15, '45', 'Proof of vaccination', '5/29/2014', '6');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (16, '5', 'Proof of vaccination', '7/31/2021', '12');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (17, '36', 'High school transcript', '9/20/2006', '39');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (18, '11', 'High school transcript', '2/21/2017', '44');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (19, '18', 'Medical history form', '2/10/2011', '19');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (20, '23', 'Copy of passport', '2/25/2000', '11');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (21, '13', 'Resume', '6/25/2022', '42');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (22, '9', 'Essay', '9/24/2019', '17');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (23, '10', 'Proof of English proficiency', '1/26/2005', '16');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (24, '19', 'Copy of passport', '7/15/2005', '25');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (25, '21', 'Essay', '9/28/2007', '15');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (26, '44', 'Resume', '11/22/2001', '29');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (27, '38', 'Copy of passport', '12/6/2012', '9');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (28, '7', 'Resume', '4/14/2016', '46');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (29, '15', 'Medical history form', '12/31/2001', '38');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (30, '16', 'Resume', '7/13/2019', '27');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (31, '34', 'High school transcript', '3/9/2018', '35');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (32, '2', 'Essay', '10/31/2017', '34');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (33, '46', 'Medical history form', '11/3/2003', '32');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (34, '47', 'Copy of passport', '11/20/2005', '43');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (35, '48', 'Proof of English proficiency', '5/7/2017', '50');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (36, '39', 'Financial statement', '8/15/2014', '36');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (37, '33', 'Essay', '12/31/2014', '5');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (38, '42', 'Personal statement', '5/5/2012', '24');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (39, '24', 'Copy of passport', '8/13/2019', '48');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (40, '12', 'Proof of vaccination', '11/13/2010', '4');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (41, '25', 'Resume', '5/19/2011', '14');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (42, '4', 'Personal statement', '12/10/2018', '30');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (43, '41', 'Medical history form', '4/26/2016', '37');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (44, '3', 'Proof of vaccination', '5/19/2017', '3');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (45, '1', 'Resume', '10/21/2007', '31');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (46, '14', 'Essay', '12/13/2013', '8');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (47, '32', 'Copy of passport', '12/30/2003', '20');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (48, '29', 'High school transcript', '7/19/2004', '21');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (49, '49', 'Essay', '5/6/2005', '22');
insert into Document (DocumentID, ApplicationID, DocumentType, UploadDate, ChecklistID) values (50, '26', 'Proof of vaccination', '6/17/2005', '23');

