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