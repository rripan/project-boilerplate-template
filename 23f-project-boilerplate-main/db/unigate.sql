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

-- Table: Application
CREATE TABLE Application (
    ApplicationID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    SubmissionDate char,
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

-- Table: Checklist
CREATE TABLE Checklist (
    ChecklistID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    Description VARCHAR(200) NOT NULL,
    Status ENUM('Incomplete', 'Complete') NOT NULL,
    CONSTRAINT FK_Checklist_Application FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
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
    EventDate char
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

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (1, 45, 'odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia', 837310910, 868801349, 844062302);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (2, 43, 'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque', 591072479, 780426706, 639748235);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (3, 7, 'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis', 5828302, 989699173, 151906597);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (4, 39, 'ante ipsum primis in faucibus orci luctus et ultrices posuere', 170410876, 598580082, 686501173);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (5, 14, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vita', 285762063, 107203681, 964546836);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (6, 20, 'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accum', 956909021, 207825152, 786278305);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (7, 16, 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 214508511, 636475431, 583455436);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (8, 35, 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elem', 914388191, 465685967, 516685324);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (9, 11, 'feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imper', 607018395, 686000397, 646388613);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (10, 43, 'in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nasc', 499397388, 753162584, 918894793);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (11, 41, 'donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultric', 159024360, 82572139, 276708040);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (12, 23, 'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu ni', 684362137, 320397112, 966151793);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (13, 48, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est d', 99935623, 672374411, 80005181);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (14, 20, 'in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae', 326234238, 617084189, 224578086);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (15, 5, 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mat', 3619028, 746567609, 154214846);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (16, 17, 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', 943175377, 456433080, 944657735);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (17, 42, 'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis', 313030688, 742759571, 433665079);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (18, 46, 'at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rut', 446822039, 699404398, 51564032);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (19, 3, 'ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo', 21697170, 79319187, 632318723);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (20, 25, 'erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', 335323563, 48893424, 99839088);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (21, 7, 'vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia', 818169601, 486334931, 795825646);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (22, 17, 'sed interdum venenatis turpis enim blandit mi in porttitor pede', 462911356, 566133419, 654800194);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (23, 17, 'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat', 619118608, 265566445, 317712880);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (24, 26, 'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis ', 99213664, 78285128, 254059910);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (25, 11, 'ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit', 415294650, 790337893, 478972415);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (26, 40, 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan to', 410712542, 984148841, 767010941);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (27, 19, 'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet', 163122975, 53785400, 995657692);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (28, 13, 'dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nun', 258979989, 604590, 774306403);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (29, 45, 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mau', 946832832, 234139281, 341104236);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (30, 50, 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis', 270761922, 568671559, 224570280);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (31, 3, 'amet nulla quisque arcu libero rutrum ac lobortis vel dapibus', 509664298, 384182467, 974296282);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (32, 2, 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis', 714601160, 189180720, 226683896);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (33, 22, 'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam', 791140359, 376360498, 925044731);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (34, 46, 'quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus', 77927428, 372769885, 294383424);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (35, 38, 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucib', 661581111, 724559301, 363444184);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (36, 49, 'ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer', 66029657, 859775927, 714740145);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (37, 17, 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lect', 505729071, 132826780, 886480359);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (38, 35, 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna', 9920862, 643052050, 988678832);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (39, 34, 'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', 987676785, 146308549, 209444511);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (40, 14, 'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur', 267705819, 691572981, 565895110);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (41, 6, 'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet', 883230996, 967097717, 883149408);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (42, 16, 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucib', 253316844, 981207954, 539864324);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (43, 48, 'nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in', 81043770, 613211821, 196624603);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (44, 43, 'adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien', 116114788, 4730523, 158473288);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (45, 30, 'morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit', 542477526, 625056441, 677563171);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (46, 25, 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cra', 547666213, 599244900, 589179780);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (47, 47, 'turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis al', 260690522, 338088508, 991667375);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (48, 8, 'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur', 22023798, 314385755, 85148854);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (49, 15, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 185153634, 124831382, 320002260);

INSERT INTO UniGate.Applicant (ApplicantID, PersonID, HighSchool, DepositID, ApplicationID, SurveyID) VALUES (50, 19, 'nisl nunc rhoncus dui vel sem sed sagittis nam congue risus', 934792808, 376447941, 284418397);


INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (1, 21, '6', 'Submitted', 1504299267, 1, 1, 1, 1);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (2, 41, '3', 'Accepted', 754975483, 2, 2, 2, 2);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (3, 3, '9', 'Accepted', 564601112, 3, 3, 3, 3);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (4, 27, '7', 'Accepted', 482975308, 4, 4, 4, 4);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (5, 24, '8', 'Accepted', 1195470701, 5, 5, 5, 5);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (6, 21, '8', 'Rejected', 1804943624, 6, 6, 6, 6);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (7, 12, '7', 'Rejected', 564601112, 7, 7, 7, 7);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (8, 5, '1', 'Rejected', 1951664230, 8, 8, 8, 8);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (9, 42, '6', 'Rejected', 1117198452, 9, 9, 9, 9);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (10, 35, '1', 'Accepted', 2042914671, 10, 10, 10, 10);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (11, 49, '8', 'Rejected', 482975308, 11, 11, 11, 11);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (12, 47, '7', 'Accepted', 436360375, 12, 12, 12, 12);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (13, 14, '1', 'Rejected', 1806907873, 13, 13, 13, 13);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (14, 39, '4', 'Submitted', 628290860, 14, 14, 14, 14);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (15, 21, '7', 'Rejected', 482975308, 15, 15, 15, 15);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (16, 9, '1', 'Submitted', 37284891, 16, 16, 16, 16);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (17, 50, '1', 'Rejected', 754975483, 17, 17, 17, 17);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (18, 34, '1', 'Accepted', 482975308, 18, 18, 18, 18);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (19, 49, '1', 'Accepted', 1056181021, 19, 19, 19, 19);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (20, 1, '9', 'Rejected', 300836671, 20, 20, 20, 20);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (21, 15, '1', 'Submitted', 996593668, 21, 21, 21, 21);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (22, 5, '7', 'Accepted', 996593668, 22, 22, 22, 22);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (23, 31, '2', 'Submitted', 17384849, 23, 23, 23, 23);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (24, 49, '1', 'Submitted', 781404917, 24, 24, 24, 24);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (25, 31, '7', 'Rejected', 2091129208, 25, 25, 25, 25);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (26, 28, '6', 'Submitted', 1804943624, 26, 26, 26, 26);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (27, 38, '5', 'Submitted', 17384849, 27, 27, 27, 27);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (28, 11, '6', 'Accepted', 996593668, 28, 28, 28, 28);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (29, 30, '1', 'Submitted', 2091129208, 29, 29, 29, 29);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (30, 18, '1', 'Submitted', 585825655, 30, 30, 30, 30);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (31, 21, '4', 'Submitted', 753309918, 31, 31, 31, 31);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (32, 40, '5', 'Accepted', 17384849, 32, 32, 32, 32);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (33, 43, '1', 'Rejected', 1862952405, 33, 33, 33, 33);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (34, 1, '1', 'Submitted', 7869449, 34, 34, 34, 34);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (35, 5, '5', 'Submitted', 1910236217, 35, 35, 35, 35);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (36, 13, '1', 'Accepted', 1951664230, 36, 36, 36, 36);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (37, 11, '7', 'Submitted', 1792569796, 37, 37, 37, 37);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (38, 46, '5', 'Accepted', 1806907873, 38, 38, 38, 38);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (39, 38, '8', 'Accepted', 686987445, 39, 39, 39, 39);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (40, 6, '1', 'Submitted', 729337753, 40, 40, 40, 40);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (41, 49, '1', 'Submitted', 37284891, 41, 41, 41, 41);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (42, 34, '6', 'Accepted', 1195470701, 42, 42, 42, 42);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (43, 23, '2', 'Submitted', 1117198452, 43, 43, 43, 43);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (44, 8, '5', 'Rejected', 996593668, 44, 44, 44, 44);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (45, 24, '9', 'Accepted', 1752821892, 45, 45, 45, 45);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (46, 17, '1', 'Rejected', 1996662616, 46, 46, 46, 46);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (47, 42, '6', 'Rejected', 754975483, 47, 47, 47, 47);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (48, 26, '1', 'Rejected', 628290860, 48, 48, 48, 48);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (49, 32, '8', 'Accepted', 1804943624, 49, 49, 49, 49);

INSERT INTO UniGate.Application (ApplicationID, ApplicantID, SubmissionDate, Status, GuidanceCounsellorID, FinancialAidID, FinancialInformationID, ChecklistID, DecisionID) VALUES (50, 16, '6', 'Accepted', 1975728602, 50, 50, 50, 50);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (1, 13, 1);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (2, 3, 2);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (3, 33, 3);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (4, 28, 4);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (5, 27, 5);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (6, 23, 6);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (7, 24, 7);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (8, 26, 8);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (9, 4, 9);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (10, 6, 10);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (11, 7, 11);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (12, 20, 12);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (13, 14, 13);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (14, 21, 14);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (15, 48, 15);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (16, 44, 16);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (17, 47, 17);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (18, 36, 18);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (19, 11, 19);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (20, 38, 20);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (22, 50, 22);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (25, 46, 25);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (26, 22, 26);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (28, 8, 28);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (29, 16, 29);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (30, 30, 30);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (33, 39, 33);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (34, 40, 34);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (37, 17, 37);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (39, 31, 39);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (40, 5, 40);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (41, 9, 41);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (43, 1, 43);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (44, 34, 44);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (45, 42, 45);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (46, 15, 46);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (47, 12, 47);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (48, 19, 48);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (49, 37, 49);

INSERT INTO UniGate.AdmissionsOfficer (AdmissionsOfficerID, PersonID, UniversityID)
VALUES (50, 35, 50);


INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (39, 2);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (25, 3);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (22, 4);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (28, 4);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (50, 4);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (27, 5);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (5, 6);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (25, 6);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (49, 6);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (42, 7);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (35, 11);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (7, 12);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (7, 13);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (23, 13);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (49, 14);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (24, 15);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (48, 16);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (21, 17);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (30, 18);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (23, 20);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (9, 21);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (15, 23);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (42, 23);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (13, 24);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (18, 24);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (7, 28);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (4, 29);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (7, 30);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (32, 30);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (44, 30);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (12, 31);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (3, 32);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (7, 33);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (40, 35);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (18, 36);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (19, 36);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (4, 37);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (36, 38);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (11, 39);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (22, 39);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (10, 40);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (26, 43);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (49, 44);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (22, 45);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (5, 46);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (14, 46);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (50, 46);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (23, 48);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (10, 49);

INSERT INTO UniGate.AttendsEvents (ApplicantID, EventID)
VALUES (43, 49);


INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (1, 27, 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (2, 37, 'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (3, 7, 'et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (4, 39, 'potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (5, 47, 'vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (6, 20, 'diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (7, 9, 'odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (8, 1, 'quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (9, 5, 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (10, 44, 'nullam sit amet turpis elementum ligula vehicula consequat morbi a', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (11, 13, 'vel lectus in quam fringilla rhoncus mauris enim leo rhoncus', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (12, 5, 'eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (13, 33, 'velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (14, 28, 'nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (15, 28, 'nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (16, 29, 'lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (17, 11, 'nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (18, 38, 'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (19, 5, 'nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (20, 16, 'cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (21, 40, 'eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (22, 18, 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (23, 34, 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (24, 14, 'tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (25, 14, 'ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (26, 23, 'odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (27, 25, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (28, 47, 'vestibulum proin eu mi nulla ac enim in tempor turpis', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (29, 24, 'ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (30, 50, 'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (31, 35, 'habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (32, 5, 'sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (33, 43, 'consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (34, 15, 'id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (35, 9, 'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (36, 44, 'dui nec nisi volutpat eleifend donec ut dolor morbi vel', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (37, 31, 'varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (38, 3, 'purus sit amet nulla quisque arcu libero rutrum ac lobortis vel', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (39, 40, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (40, 16, 'lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (41, 12, 'mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (42, 17, 'in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (43, 8, 'aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (44, 37, 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (45, 20, 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (46, 36, 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (47, 2, 'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (48, 6, 'odio in hac habitasse platea dictumst maecenas ut massa quis augue', 'Incomplete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (49, 27, 'convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris', 'Complete');

INSERT INTO UniGate.Checklist (ChecklistID, ApplicationID, Description, Status) VALUES (50, 23, 'curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam', 'Incomplete');


INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (1, 34, '440-457-8608', 'vhrinchishin0@people.com.cn');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (2, 10, '865-700-7487', 'csearjeant1@answers.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (3, 50, '890-833-8181', 'nsharrier2@prnewswire.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (4, 39, '274-410-4768', 'icallicott3@etsy.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (5, 21, '105-497-9222', 'wgundry4@cargocollective.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (6, 43, '790-360-7263', 'abosley5@senate.gov');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (7, 34, '244-504-4768', 'jmorbey6@sina.com.cn');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (8, 3, '469-227-4468', 'pvakhrushin7@businesswire.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (9, 14, '640-141-1619', 'fscutter8@diigo.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (10, 26, '636-286-2687', 'epowles9@hhs.gov');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (11, 35, '375-784-8781', 'kloddena@pinterest.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (12, 26, '910-619-8698', 'ahastedb@wikia.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (13, 19, '829-298-0952', 'shillanc@sun.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (14, 28, '248-681-4112', 'ciannellod@illinois.edu');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (15, 20, '628-437-4700', 'sfarlowe@miibeian.gov.cn');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (16, 31, '373-144-1377', 'kduvalf@admin.ch');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (17, 36, '932-911-5920', 'couldg@wikimedia.org');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (18, 21, '665-121-5382', 'amorenah@spotify.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (19, 42, '911-666-9111', 'gpulsfordi@bloomberg.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (20, 11, '254-162-6237', 'pkingdonj@omniture.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (21, 10, '340-624-3398', 'skeenek@cbslocal.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (22, 37, '350-529-2236', 'ccamelial@hubpages.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (23, 48, '491-782-8007', 'gbrummellm@symantec.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (24, 3, '716-104-6380', 'cwellann@taobao.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (25, 32, '956-593-9632', 'rharrhyo@yahoo.co.jp');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (26, 27, '378-845-8173', 'wmassowp@pcworld.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (27, 29, '806-778-0240', 'bfurmageq@youtu.be');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (28, 34, '856-554-8912', 'ljostr@pagesperso-orange.fr');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (29, 3, '228-446-0278', 'wmatelyunass@ucsd.edu');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (30, 19, '588-988-3615', 'sollerenshawt@acquirethisname.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (31, 31, '166-701-1959', 'ecasau@yellowpages.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (32, 35, '411-247-0904', 'rsummerliev@huffingtonpost.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (33, 19, '478-188-7350', 'chundalw@dailymail.co.uk');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (34, 33, '949-915-1537', 'ggriptonx@usa.gov');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (35, 16, '308-955-9069', 'vbeety@histats.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (36, 29, '246-179-2756', 'tfarnanz@google.co.jp');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (37, 25, '934-986-0351', 'mebi10@archive.org');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (38, 3, '476-769-9205', 'rduquesnay11@reference.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (39, 6, '991-239-8480', 'kprickett12@upenn.edu');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (40, 15, '296-355-1098', 'kcorhard13@symantec.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (41, 38, '934-802-3283', 'fyeldon14@elegantthemes.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (42, 2, '637-734-7033', 'mcristobal15@php.net');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (43, 4, '260-166-2140', 'cguitton16@accuweather.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (44, 37, '720-934-3128', 'bfradson17@economist.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (45, 11, '119-375-7808', 'mmchaffy18@newsvine.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (46, 49, '692-675-6096', 'gzorzoni19@g.co');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (47, 22, '341-733-7458', 'hyurkevich1a@europa.eu');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (48, 31, '509-266-0670', 'ldonald1b@squidoo.com');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (49, 5, '738-214-5916', 'vbraham1c@archive.org');

INSERT INTO UniGate.Contact (ContactID, PersonID, PhoneNumber, EmailAddress)
VALUES (50, 14, '324-269-8122', 'scharrier1d@ovh.net');


INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (1, 1, 'Rejected', '2', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (2, 2, 'Waitlisted', '4', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (3, 3, 'Rejected', '7', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (4, 4, 'Rejected', '8', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (5, 5, 'Accepted', '1', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (6, 6, 'Accepted', '8', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (7, 7, 'Accepted', '3', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (8, 8, 'Accepted', '1', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (9, 9, 'Rejected', '1', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (10, 10, 'Rejected', '7', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (11, 11, 'Waitlisted', '3', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (12, 12, 'Rejected', '8', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (13, 13, 'Waitlisted', '1', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (14, 14, 'Waitlisted', '1', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (15, 15, 'Rejected', '5', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (16, 16, 'Accepted', '7', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (17, 17, 'Waitlisted', '9', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (18, 18, 'Waitlisted', '6', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (19, 19, 'Accepted', '5', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (20, 20, 'Rejected', '6', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (21, 21, 'Waitlisted', '9', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (22, 22, 'Waitlisted', '8', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (23, 23, 'Accepted', '1', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (24, 24, 'Accepted', '9', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (25, 25, 'Waitlisted', '3', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (26, 26, 'Accepted', '2', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (27, 27, 'Waitlisted', '2', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (28, 28, 'Rejected', '7', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (29, 29, 'Accepted', '5', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (30, 30, 'Rejected', '2', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (31, 31, 'Rejected', '1', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (32, 32, 'Accepted', '3', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (33, 33, 'Waitlisted', '4', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (34, 34, 'Waitlisted', '1', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (35, 35, 'Rejected', '1', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (36, 36, 'Waitlisted', '2', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (37, 37, 'Rejected', '4', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (38, 38, 'Rejected', '1', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (39, 39, 'Rejected', '9', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (40, 40, 'Waitlisted', '8', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (41, 41, 'Accepted', '9', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (42, 42, 'Accepted', '1', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (43, 43, 'Rejected', '7', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (44, 44, 'Accepted', '1', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (45, 45, 'Accepted', '7', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (46, 46, 'Accepted', '1', 'Dear Applicant,

Congratulations! We are pleased to inform you that you have been accepted into our college. Your application stood out to us in many ways, and we are excited about what you will bring to our campus community. We saw great potential in your achievements and your character, and we believe you will thrive here. Welcome aboard!', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (47, 47, 'Waitlisted', '7', 'Dear Applicant,

Thank you for your patience during our admission process. We have decided to place your application on our waitlist. This decision reflects the competitive nature of this year’s applicant pool and not a lack of qualification on your part. We encourage you to remain hopeful and to update us with any new achievements or information that may strengthen your application.', 1);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (48, 48, 'Rejected', '1', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (49, 49, 'Rejected', '7', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);

INSERT INTO UniGate.Decision (DecisionID, ApplicationID, Result, DecisionDate, DecisionLetter, ContinuedInterest) VALUES (50, 50, 'Rejected', '9', 'Dear Applicant,

After thorough consideration of your application, we regret to inform you that we are unable to offer you admission at this time. Please understand that this decision is not a reflection of your abilities or potential but rather the result of an exceptionally competitive applicant pool this year. We are grateful for your interest in our college and wish you the best in your future academic pursuits.', 0);


INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (15, 50, 60000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (58, 50, 50000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (64, 50, 30000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (264, 50, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (307, 50, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (354, 50, 80000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (397, 50, 80000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (406, 50, 40000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (457, 50, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (471, 50, 100000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (525, 50, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (550, 50, 70000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (582, 50, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (637, 50, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (681, 50, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (690, 50, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (750, 50, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (783, 50, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (807, 50, 50000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (861, 50, 70000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (914, 50, 20000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (953, 50, 20000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (972, 50, 10000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (23, 49, 40000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (57, 49, 60000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (66, 49, 70000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (122, 49, 50000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (177, 49, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (208, 49, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (221, 49, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (345, 49, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (433, 49, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (437, 49, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (493, 49, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (500, 49, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (535, 49, 20000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (573, 49, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (616, 49, 10000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (660, 49, 100000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (739, 49, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (788, 49, 40000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (868, 49, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (888, 49, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (906, 49, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (950, 49, 20000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (991, 49, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (25, 48, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (47, 48, 80000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (91, 48, 90000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (111, 48, 10000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (168, 48, 100000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (195, 48, 100000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (269, 48, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (342, 48, 80000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (378, 48, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (432, 48, 80000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (462, 48, 50000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (467, 48, 10000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (527, 48, 10000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (554, 48, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (585, 48, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (601, 48, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (626, 48, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (665, 48, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (711, 48, 30000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (721, 48, 90000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (746, 48, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (787, 48, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (838, 48, 60000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (877, 48, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (901, 48, 20000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (968, 48, 40000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (19, 47, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (44, 47, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (110, 47, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (142, 47, 70000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (194, 47, 50000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (368, 47, 20000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (383, 47, 40000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (430, 47, 10000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (512, 47, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (558, 47, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (569, 47, 40000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (591, 47, 40000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (635, 47, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (671, 47, 10000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (697, 47, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (717, 47, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (833, 47, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (862, 47, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (889, 47, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (992, 47, 40000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (16, 46, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (133, 46, 100000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (192, 46, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (220, 46, 60000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (270, 46, 30000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (348, 46, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (377, 46, 30000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (435, 46, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (513, 46, 50000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (577, 46, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (628, 46, 40000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (667, 46, 10000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (704, 46, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (734, 46, 20000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (765, 46, 60000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (897, 46, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (943, 46, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (989, 46, 10000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (86, 45, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (186, 45, 30000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (189, 45, 10000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (280, 45, 20000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (337, 45, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (411, 45, 80000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (439, 45, 30000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (509, 45, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (561, 45, 40000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (611, 45, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (642, 45, 60000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (661, 45, 90000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (755, 45, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (844, 45, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (882, 45, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (922, 45, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (938, 45, 40000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (978, 45, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (3, 44, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (53, 44, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (127, 44, 50000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (178, 44, 100000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (236, 44, 70000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (263, 44, 10000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (304, 44, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (375, 44, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (438, 44, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (474, 44, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (515, 44, 90000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (540, 44, 60000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (563, 44, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (674, 44, 90000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (810, 44, 90000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (839, 44, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (942, 44, 70000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (981, 44, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (24, 43, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (38, 43, 30000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (90, 43, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (171, 43, 40000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (223, 43, 20000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (259, 43, 100000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (319, 43, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (367, 43, 10000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (405, 43, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (447, 43, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (497, 43, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (695, 43, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (723, 43, 60000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (796, 43, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (824, 43, 50000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (853, 43, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (873, 43, 70000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (936, 43, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (48, 42, 70000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (71, 42, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (146, 42, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (161, 42, 10000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (216, 42, 40000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (271, 42, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (282, 42, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (330, 42, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (404, 42, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (443, 42, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (516, 42, 70000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (570, 42, 40000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (640, 42, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (652, 42, 90000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (692, 42, 30000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (737, 42, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (760, 42, 50000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (800, 42, 30000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (881, 42, 40000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (975, 42, 10000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (13, 41, 40000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (94, 41, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (150, 41, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (262, 41, 90000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (306, 41, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (442, 41, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (470, 41, 50000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (639, 41, 50000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (728, 41, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (813, 41, 80000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (872, 41, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (961, 41, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (14, 40, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (74, 40, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (145, 40, 10000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (190, 40, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (245, 40, 70000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (275, 40, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (315, 40, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (361, 40, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (398, 40, 70000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (431, 40, 100000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (446, 40, 70000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (505, 40, 30000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (532, 40, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (566, 40, 100000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (612, 40, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (622, 40, 100000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (694, 40, 20000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (804, 40, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (832, 40, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (893, 40, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (925, 40, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (982, 40, 80000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (1, 39, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (32, 39, 100000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (83, 39, 70000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (155, 39, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (174, 39, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (215, 39, 80000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (231, 39, 50000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (277, 39, 10000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (309, 39, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (350, 39, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (376, 39, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (423, 39, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (441, 39, 70000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (466, 39, 90000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (526, 39, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (556, 39, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (581, 39, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (631, 39, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (679, 39, 70000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (691, 39, 40000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (766, 39, 70000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (791, 39, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (859, 39, 10000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (990, 39, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (49, 38, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (70, 38, 30000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (143, 38, 10000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (185, 38, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (212, 38, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (234, 38, 100000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (276, 38, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (286, 38, 30000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (341, 38, 100000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (353, 38, 40000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (409, 38, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (458, 38, 20000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (508, 38, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (583, 38, 90000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (693, 38, 80000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (718, 38, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (751, 38, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (803, 38, 100000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (811, 38, 30000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (944, 38, 90000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (994, 38, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (9, 37, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (93, 37, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (121, 37, 50000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (128, 37, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (176, 37, 50000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (268, 37, 90000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (290, 37, 20000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (321, 37, 20000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (393, 37, 80000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (408, 37, 10000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (465, 37, 100000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (485, 37, 60000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (618, 37, 10000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (650, 37, 60000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (654, 37, 30000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (736, 37, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (761, 37, 10000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (790, 37, 90000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (815, 37, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (930, 37, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (932, 37, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (969, 37, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (141, 36, 80000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (156, 36, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (193, 36, 20000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (238, 36, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (292, 36, 50000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (322, 36, 50000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (364, 36, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (379, 36, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (548, 36, 20000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (603, 36, 50000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (699, 36, 60000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (741, 36, 90000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (767, 36, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (802, 36, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (886, 36, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (910, 36, 80000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (980, 36, 30000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (10, 35, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (40, 35, 80000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (69, 35, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (100, 35, 20000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (180, 35, 90000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (219, 35, 20000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (308, 35, 100000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (311, 35, 70000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (434, 35, 40000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (531, 35, 90000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (596, 35, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (677, 35, 40000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (705, 35, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (731, 35, 70000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (780, 35, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (817, 35, 10000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (892, 35, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (916, 35, 100000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (967, 35, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (17, 34, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (65, 34, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (152, 34, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (173, 34, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (230, 34, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (267, 34, 10000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (362, 34, 100000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (388, 34, 60000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (417, 34, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (488, 34, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (506, 34, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (546, 34, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (647, 34, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (710, 34, 40000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (719, 34, 60000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (745, 34, 10000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (781, 34, 50000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (821, 34, 100000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (850, 34, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (891, 34, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (923, 34, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (109, 33, 40000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (265, 33, 10000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (347, 33, 30000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (559, 33, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (608, 33, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (764, 33, 20000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (795, 33, 40000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (829, 33, 40000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (851, 33, 80000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (894, 33, 40000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (900, 33, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (960, 33, 90000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (30, 32, 30000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (80, 32, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (154, 32, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (187, 32, 50000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (228, 32, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (334, 32, 30000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (455, 32, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (543, 32, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (574, 32, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (599, 32, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (653, 32, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (712, 32, 20000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (714, 32, 80000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (763, 32, 80000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (805, 32, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (883, 32, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (966, 32, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (63, 31, 60000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (116, 31, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (147, 31, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (256, 31, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (317, 31, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (521, 31, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (602, 31, 60000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (641, 31, 70000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (666, 31, 30000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (756, 31, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (786, 31, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (855, 31, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (898, 31, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (908, 31, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (985, 31, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (8, 30, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (117, 30, 20000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (134, 30, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (254, 30, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (326, 30, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (370, 30, 40000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (385, 30, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (450, 30, 30000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (478, 30, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (502, 30, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (533, 30, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (567, 30, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (610, 30, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (713, 30, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (743, 30, 70000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (775, 30, 90000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (837, 30, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (858, 30, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (878, 30, 10000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (934, 30, 50000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (46, 29, 80000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (72, 29, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (139, 29, 40000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (224, 29, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (338, 29, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (359, 29, 80000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (387, 29, 100000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (412, 29, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (453, 29, 100000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (475, 29, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (519, 29, 90000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (597, 29, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (698, 29, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (738, 29, 20000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (806, 29, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (816, 29, 20000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (957, 29, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (52, 28, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (118, 28, 50000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (125, 28, 50000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (172, 28, 10000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (232, 28, 60000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (252, 28, 30000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (281, 28, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (328, 28, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (374, 28, 80000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (499, 28, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (557, 28, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (564, 28, 90000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (645, 28, 100000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (655, 28, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (709, 28, 10000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (774, 28, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (869, 28, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (927, 28, 10000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (946, 28, 20000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (22, 27, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (87, 27, 70000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (103, 27, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (129, 27, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (198, 27, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (248, 27, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (273, 27, 50000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (298, 27, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (349, 27, 40000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (401, 27, 100000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (452, 27, 10000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (489, 27, 90000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (568, 27, 70000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (595, 27, 70000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (682, 27, 10000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (700, 27, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (727, 27, 80000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (753, 27, 70000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (797, 27, 50000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (822, 27, 20000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (856, 27, 60000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (870, 27, 60000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (956, 27, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (995, 27, 10000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (21, 26, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (54, 26, 100000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (99, 26, 30000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (149, 26, 20000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (181, 26, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (244, 26, 50000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (331, 26, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (394, 26, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (448, 26, 60000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (468, 26, 50000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (565, 26, 60000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (598, 26, 30000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (644, 26, 30000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (672, 26, 90000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (733, 26, 40000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (759, 26, 60000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (782, 26, 50000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (826, 26, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (857, 26, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (902, 26, 80000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (977, 26, 90000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (60, 25, 40000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (113, 25, 60000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (148, 25, 100000.00, '3');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (179, 25, 100000.00, '7');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (211, 25, 30000.00, '6');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (239, 25, 10000.00, '5');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (272, 25, 100000.00, '9');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (380, 25, 30000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (444, 25, 80000.00, '1');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (498, 25, 100000.00, '8');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (560, 25, 80000.00, '4');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (613, 25, 60000.00, '2');

INSERT INTO UniGate.Deposit (DepositID, ApplicantID, Amount, DatePaid) VALUES (646, 25, 30000.00, '4');


INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (1, 'Application essay writing workshop', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (2, 'College fair at local community center', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (3, 'Open house event for high school seniors', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (4, 'Financial aid information session', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (5, 'Panel discussion with current college students', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (6, 'Open house event for high school seniors', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (7, 'Open house event for high school seniors', '5');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (8, 'College fair at local community center', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (9, 'Open house event for high school seniors', '2');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (10, 'Admissions workshop for parents and students', '7');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (11, 'Meet and greet with college faculty', '3');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (12, 'Panel discussion with current college students', '9');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (13, 'Admissions workshop for parents and students', '7');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (14, 'Meet and greet with college faculty', '8');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (15, 'Alumni networking event for recent graduates', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (16, 'College fair at local community center', '4');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (17, 'Campus tour for incoming freshmen', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (18, 'Panel discussion with current college students', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (19, 'Alumni networking event for recent graduates', '8');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (20, 'College fair at local community center', '3');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (21, 'Virtual information session for prospective students', '2');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (22, 'Financial aid information session', '7');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (23, 'Campus tour for incoming freshmen', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (24, 'Campus tour for incoming freshmen', '5');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (25, 'Panel discussion with current college students', '8');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (26, 'Alumni networking event for recent graduates', '3');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (27, 'Application essay writing workshop', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (28, 'Meet and greet with college faculty', '7');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (29, 'Alumni networking event for recent graduates', '8');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (30, 'Panel discussion with current college students', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (31, 'Application essay writing workshop', '2');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (32, 'Panel discussion with current college students', '2');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (33, 'Virtual information session for prospective students', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (34, 'College fair at local community center', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (35, 'Campus tour for incoming freshmen', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (36, 'Meet and greet with college faculty', '9');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (37, 'Alumni networking event for recent graduates', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (38, 'Panel discussion with current college students', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (39, 'College fair at local community center', '4');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (40, 'Financial aid information session', '2');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (41, 'College fair at local community center', '1');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (42, 'Alumni networking event for recent graduates', '5');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (43, 'Campus tour for incoming freshmen', '3');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (44, 'Virtual information session for prospective students', '5');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (45, 'Alumni networking event for recent graduates', '8');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (46, 'Application essay writing workshop', '5');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (47, 'Virtual information session for prospective students', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (48, 'Panel discussion with current college students', '4');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (49, 'Admissions workshop for parents and students', '6');

INSERT INTO UniGate.Event (EventID, Description, EventDate)
VALUES (50, 'College fair at local community center', '8');


INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (1, 2, 'Essay or personal statement', 94143.54);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (2, 24, 'Proof of income below a certain threshold', 240410.68);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (3, 6, 'Enrollment in specific program or major', 91062.77);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (4, 6, 'Community service involvement', 524701.51);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (5, 33, 'Demonstrated financial need', 205689.57);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (6, 39, 'First-generation college student', 175916.39);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (7, 28, 'Participation in extracurricular activities', 30628.14);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (8, 27, 'First-generation college student', 837255.23);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (9, 38, 'Submission of FAFSA form', 852242.14);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (10, 14, 'Essay or personal statement', 99879.43);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (11, 15, 'Minority status', 430722.42);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (12, 48, 'Demonstrated financial need', 743937.82);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (13, 30, 'Proof of income below a certain threshold', 129389.51);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (14, 44, 'Submission of FAFSA form', 184453.41);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (15, 39, 'Submission of FAFSA form', 575733.29);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (16, 6, 'Academic merit', 705192.82);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (17, 49, 'Participation in extracurricular activities', 792531.77);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (18, 25, 'First-generation college student', 136909.26);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (19, 19, 'First-generation college student', 736758.51);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (20, 6, 'First-generation college student', 350482.35);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (21, 12, 'Enrollment in specific program or major', 707459.18);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (22, 47, 'Proof of income below a certain threshold', 362263.71);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (23, 50, 'Participation in extracurricular activities', 939109.71);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (24, 14, 'Minority status', 404788.22);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (25, 30, 'Essay or personal statement', 120086.28);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (26, 11, 'Academic merit', 863466.22);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (27, 12, 'Academic merit', 440275.91);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (28, 12, 'Demonstrated financial need', 303112.48);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (29, 39, 'Participation in extracurricular activities', 776664.66);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (30, 8, 'Enrollment in specific program or major', 538858.91);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (31, 38, 'Demonstrated financial need', 246642.85);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (32, 38, 'Proof of income below a certain threshold', 326357.96);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (33, 30, 'Submission of FAFSA form', 256062.27);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (34, 50, 'Essay or personal statement', 989943.98);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (35, 42, 'Demonstrated financial need', 44368.54);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (36, 49, 'Proof of income below a certain threshold', 192963.48);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (37, 44, 'Academic merit', 892376.99);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (38, 16, 'Essay or personal statement', 938428.31);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (39, 13, 'Demonstrated financial need', 722883.72);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (40, 15, 'Academic merit', 491066.07);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (41, 35, 'Proof of income below a certain threshold', 774474.60);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (42, 23, 'First-generation college student', 448779.20);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (43, 46, 'Participation in extracurricular activities', 687255.08);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (44, 48, 'Academic merit', 694440.27);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (45, 9, 'Minority status', 751212.08);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (46, 11, 'Academic merit', 498498.34);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (47, 37, 'Participation in extracurricular activities', 710299.40);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (48, 40, 'Minority status', 232260.96);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (49, 36, 'Participation in extracurricular activities', 504971.82);

INSERT INTO UniGate.FinancialAid (FinancialAidID, ApplicantID, Conditions, Amount)
VALUES (50, 2, 'First-generation college student', 273054.60);


INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (1, 1, 60000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (2, 41, 50000.00, 3800.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (3, 8, 60000.00, 8200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (4, 6, 60000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (5, 36, 58000.00, 9100.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (6, 27, 50000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (7, 21, 60000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (8, 30, 32000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (9, 36, 53000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (10, 46, 53000.00, 8200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (11, 20, 75000.00, 3800.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (12, 27, 75000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (13, 32, 53000.00, 8200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (14, 28, 48000.00, 4200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (15, 47, 42000.00, 4800.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (16, 13, 60000.00, 9100.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (17, 38, 60000.00, 4200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (18, 31, 75000.00, 7500.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (19, 26, 42000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (20, 36, 50000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (21, 39, 50000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (22, 25, 32000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (23, 18, 90000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (24, 50, 90000.00, 4200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (25, 13, 48000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (26, 47, 48000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (27, 5, 90000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (28, 20, 67000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (29, 21, 53000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (30, 43, 67000.00, 8200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (31, 37, 60000.00, 4800.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (32, 14, 60000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (33, 29, 90000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (34, 7, 42000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (35, 1, 48000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (36, 40, 58000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (37, 13, 90000.00, 9100.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (38, 48, 58000.00, 9100.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (39, 35, 32000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (40, 21, 67000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (41, 32, 75000.00, 3000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (42, 30, 90000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (43, 4, 32000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (44, 38, 60000.00, 6400.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (45, 5, 67000.00, 4200.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (46, 9, 67000.00, 5000.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (47, 24, 53000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (48, 11, 67000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (49, 6, 60000.00, 5600.00);

INSERT INTO UniGate.FinancialInformation (FinancialInformationID, ApplicationID, EstimatedCost, Taxes)
VALUES (50, 19, 90000.00, 5000.00);


INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (7869449, 30, '#8b2');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (17384849, 39, '#747');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (30358770, 27, '#7d7');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (37284891, 14, '#fb4');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (106009575, 50, '#e5e');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (141463877, 18, '#319');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (278613721, 18, '#313');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (300836671, 32, '#937');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (371421244, 16, '#dd7');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (436360375, 29, '#0d6');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (482975308, 17, '#417');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (564601112, 10, '#dd1');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (565878348, 34, '#8cf');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (575126074, 32, '#310');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (585825655, 8, '#0ab');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (596340223, 47, '#a63');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (628290860, 3, '#454');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (641705766, 14, '#371');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (686987445, 47, '#947');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (729337753, 41, '#8e5');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (753309918, 34, '#260');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (754975483, 40, '#630');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (781404917, 44, '#002');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (870737936, 45, '#5cc');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (996593668, 35, '#0af');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1053487951, 34, '#b19');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1056181021, 22, '#347');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1117198452, 13, '#286');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1188280096, 6, '#e2a');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1195470701, 9, '#50d');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1219581487, 13, '#57b');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1309518939, 42, '#cb4');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1504299267, 33, '#363');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1568006923, 28, '#e79');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1668146506, 13, '#f4a');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1676366997, 16, '#557');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1715404729, 20, '#19b');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1752821892, 48, '#32d');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1792569796, 44, '#f18');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1804943624, 10, '#ec9');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1806907873, 36, '#6b2');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1862952405, 22, '#a70');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1910236217, 23, '#b52');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1951664230, 26, '#95d');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1975728602, 47, '#846');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1982170055, 11, '#b07');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (1996662616, 20, '#9e8');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (2042914671, 13, '#975');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (2048022662, 36, '#138');

INSERT INTO UniGate.GuidanceCounsellor (GuidanceCounsellorID, PersonID, HighSchool)
VALUES (2091129208, 49, '#f4c');


INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (34, 3);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (40, 4);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (37, 5);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (9, 7);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (4, 8);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (44, 8);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (8, 9);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (28, 9);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (36, 9);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (15, 10);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (9, 11);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (16, 11);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (46, 13);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (4, 14);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (24, 14);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (8, 15);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (25, 15);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (29, 15);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (21, 16);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (19, 18);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (39, 19);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (15, 20);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (22, 20);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (45, 20);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (8, 21);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (9, 22);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (17, 22);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (47, 22);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (18, 23);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (48, 23);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (7, 24);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (3, 25);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (43, 25);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (9, 27);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (39, 30);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (11, 31);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (41, 31);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (32, 32);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (16, 36);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (31, 37);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (1, 39);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (13, 39);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (27, 42);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (29, 44);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (43, 44);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (3, 46);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (27, 46);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (26, 48);

INSERT INTO UniGate.isApplicant (ApplicantID, PersonID)
VALUES (50, 49);


INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (585825655, 1);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (371421244, 3);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1715404729, 4);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1668146506, 5);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (781404917, 6);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1504299267, 6);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1309518939, 9);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (565878348, 10);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1568006923, 10);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (585825655, 12);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (585825655, 13);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1309518939, 14);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (870737936, 15);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1982170055, 15);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1996662616, 15);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1982170055, 17);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1668146506, 18);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (585825655, 19);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (30358770, 20);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1910236217, 20);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (2048022662, 21);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (2091129208, 22);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (596340223, 24);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1752821892, 24);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1910236217, 25);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1982170055, 25);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1188280096, 28);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1982170055, 29);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (753309918, 30);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (30358770, 31);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (996593668, 31);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (371421244, 32);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (141463877, 34);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (565878348, 34);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1053487951, 35);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (482975308, 36);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1195470701, 37);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (641705766, 38);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1676366997, 40);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (2042914671, 40);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (686987445, 41);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (753309918, 41);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1053487951, 42);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1188280096, 42);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (596340223, 43);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (1117198452, 44);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (754975483, 46);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (278613721, 48);

INSERT INTO UniGate.isGuidanceCounsellor (GuidanceCounsellorID, PersonID)
VALUES (436360375, 49);


INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (1, 'Jodee', '9', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (2, 'Yettie', '3', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (3, 'Leisha', '1', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (4, 'Susann', '1', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (5, 'Tabbitha', '6', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (6, 'Guinna', '8', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (7, 'Morie', '2', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (8, 'Donalt', '1', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (9, 'Zeb', '8', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (10, 'Adler', '7', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (11, 'Dorella', '7', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (12, 'Roze', '4', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (13, 'Maighdiln', '2', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (14, 'Marybeth', '3', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (15, 'Sarena', '7', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (16, 'Lavena', '3', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (17, 'Gabi', '7', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (18, 'Aryn', '6', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (19, 'Ced', '1', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (20, 'Hall', '7', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (21, 'Hortense', '1', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (22, 'Curt', '6', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (23, 'Morie', '1', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (24, 'Dinnie', '2', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (25, 'Noel', '7', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (26, 'Konstance', '2', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (27, 'Grata', '1', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (28, 'Evangelia', '8', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (29, 'Basile', '1', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (30, 'Cherie', '1', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (31, 'Aura', '8', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (32, 'Flint', '4', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (33, 'Bordy', '1', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (34, 'Mata', '1', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (35, 'Nanete', '8', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (36, 'Burnaby', '1', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (37, 'Zabrina', '1', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (38, 'Calhoun', '1', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (39, 'Elsi', '4', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (40, 'Beulah', '1', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (41, 'Anett', '2', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (42, 'Frederik', '4', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (43, 'Breena', '3', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (44, 'Tammara', '7', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (45, 'Eamon', '7', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (46, 'Basilius', '3', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (47, 'Sofia', '1', 'Guidance Counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (48, 'Petronia', '4', 'Applicant');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (49, 'Fianna', '1', 'Admissions counsellor');

INSERT INTO UniGate.Person (PersonID, Name, DOB, Type)
VALUES (50, 'Alvy', '7', 'Guidance Counsellor');


INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (1, 38, 'Creative Arts Scholarship', 30000.00, 'Participation in a leadership program');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (2, 32, 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis', 14601160.00, '189180720');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (3, 19, 'ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo', 21697170.00, '79319187');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (4, 15, 'Environmental Sustainability Scholarship', 50000.00, 'Minimum of 50 hours of volunteer work');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (5, 15, 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mat', 3619028.00, '746567609');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (6, 41, 'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet', 83230996.00, '967097717');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (7, 3, 'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis', 5828302.00, '989699173');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (8, 48, 'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur', 22023798.00, '314385755');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (9, 18, 'Community Service Scholarship', 45000.00, 'Enrolled in a STEM program');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (10, 38, 'Creative Arts Scholarship', 30000.00, 'Enrolled in a STEM program');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (11, 9, 'feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imper', 7018395.00, '686000397');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (12, 26, 'Diversity and Inclusion Scholarship', 70000.00, 'Recommendation letter from a teacher');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (13, 28, 'dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nun', 58979989.00, '604590');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (14, 5, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vita', 85762063.00, '107203681');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (15, 49, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 85153634.00, '124831382');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (16, 7, 'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 14508511.00, '636475431');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (17, 16, 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque', 43175377.00, '456433080');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (18, 37, 'Community Service Scholarship', 45000.00, 'Participation in community service activities');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (19, 27, 'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet', 63122975.00, '53785400');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (20, 6, 'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accum', 56909021.00, '207825152');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (21, 16, 'Creative Arts Scholarship', 80000.00, 'Enrolled in a STEM program');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (22, 33, 'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam', 91140359.00, '376360498');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (23, 12, 'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu ni', 84362137.00, '320397112');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (24, 9, 'Community Service Scholarship', 25000.00, 'Minimum of 50 hours of volunteer work');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (25, 20, 'erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', 35323563.00, '48893424');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (26, 24, 'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis ', 99213664.00, '78285128');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (27, 35, 'Diversity and Inclusion Scholarship', 30000.00, 'Minimum of 50 hours of volunteer work');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (28, 43, 'Entrepreneurship Scholarship', 30000.00, 'Interest in pursuing a career in healthcare');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (29, 13, 'Entrepreneurship Scholarship', 45000.00, 'Enrolled in a STEM program');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (30, 45, 'morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit', 42477526.00, '625056441');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (31, 41, 'Diversity and Inclusion Scholarship', 35000.00, 'Participation in a leadership program');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (32, 27, 'Environmental Sustainability Scholarship', 35000.00, 'Member of a minority group');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (33, 42, 'Future Leaders Scholarship', 60000.00, 'Recommendation letter from a teacher');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (34, 39, 'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', 87676785.00, '146308549');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (35, 8, 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elem', 14388191.00, '465685967');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (36, 35, 'Entrepreneurship Scholarship', 10000.00, 'Essay submission');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (37, 7, 'Health and Wellness Scholarship', 60000.00, 'Recommendation letter from a teacher');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (38, 35, 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucib', 61581111.00, '724559301');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (39, 4, 'ante ipsum primis in faucibus orci luctus et ultrices posuere', 70410876.00, '598580082');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (40, 26, 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan to', 10712542.00, '984148841');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (41, 11, 'donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultric', 59024360.00, '82572139');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (42, 17, 'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis', 13030688.00, '742759571');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (43, 2, 'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque', 91072479.00, '780426706');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (44, 14, 'Innovation and Technology Scholarship', 45000.00, 'Demonstrated financial need');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (45, 1, 'odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia', 37310910.00, '868801349');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (46, 18, 'at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rut', 46822039.00, '699404398');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (47, 47, 'turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis al', 60690522.00, '338088508');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (48, 13, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est d', 99935623.00, '672374411');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (49, 36, 'ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer', 66029657.00, '859775927');

INSERT INTO UniGate.Scholarship (ScholarshipID, ApplicantID, Name, Amount, Eligibility) VALUES (50, 30, 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis', 70761922.00, '568671559');


INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (1, 46, '9', 'a positive experience with the admissions team.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (2, 1, '6', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (3, 2, '9', 'Impressed with the level of professionalism.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (4, 21, '9', 'Looking forward to starting my studies at the university.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (5, 44, '1', 'Appreciate the prompt responses to my inquiries.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (6, 49, '5', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (7, 12, '3', 'Would like to see more diversity in the student body.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (8, 16, '5', 'Impressed with the level of professionalism.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (9, 32, '1', 'Would like to see more diversity in the student body.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (10, 6, '6', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (11, 28, '1', 'Appreciate the prompt responses to my inquiries.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (12, 1, '3', 'Very informative presentation');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (13, 26, '1', 'Impressed with the level of professionalism.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (14, 39, '1', 'Appreciate the prompt responses to my inquiries.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (15, 6, '3', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (16, 27, '1', 'Could use more clarity on the program requirements.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (17, 34, '2', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (18, 23, '2', 'Appreciate the prompt responses to my inquiries.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (19, 22, '8', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (20, 48, '3', 'Impressed with the level of professionalism.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (21, 10, '9', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (22, 50, '2', 'Would like to see more diversity in the student body.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (23, 15, '6', 'a positive experience with the admissions team.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (24, 37, '8', 'Could use more clarity on the program requirements.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (25, 34, '4', 'Thank you for the opportunity to interview for the program.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (26, 44, '7', 'a positive experience with the admissions team.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (27, 31, '5', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (28, 44, '7', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (29, 29, '1', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (30, 43, '8', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (31, 11, '3', 'Thank you for the opportunity to interview for the program.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (32, 23, '1', 'a positive experience with the admissions team.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (33, 29, '1', 'Very informative presentation');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (34, 12, '3', 'Overall');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (35, 31, '8', 'Thank you for the opportunity to interview for the program.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (36, 40, '2', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (37, 4, '2', 'Impressed with the level of professionalism.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (38, 50, '6', 'Would like to see more diversity in the student body.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (39, 44, '1', 'Would like to see more diversity in the student body.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (40, 34, '4', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (41, 22, '1', 'Could use more clarity on the program requirements.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (42, 11, '6', 'Great communication throughout the process.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (43, 28, '5', 'Thank you for the opportunity to interview for the program.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (44, 47, '6', 'Great communication throughout the process.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (45, 49, '1', 'thank you!');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (46, 8, '8', 'Appreciate the prompt responses to my inquiries.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (47, 17, '1', 'Appreciate the prompt responses to my inquiries.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (48, 1, '7', 'Found the application process to be straightforward.');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (49, 35, '2', 'Overall');

INSERT INTO UniGate.Survey (SurveyID, ApplicantID, SubmissionDate, Feedback)
VALUES (50, 36, '9', 'thank you!');