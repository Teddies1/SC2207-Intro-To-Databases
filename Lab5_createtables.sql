CREATE TABLE Zips(
	Zip varchar(6) NOT NULL PRIMARY KEY,
	City varchar(255),
	City_State varchar(255)
);

CREATE TABLE Addresses(
	Address varchar(255) NOT NULL PRIMARY KEY,
	Zip varchar(6),
	FOREIGN KEY (Zip) REFERENCES Zips(Zip)
);

CREATE TABLE Person(
	Person_ID int NOT NULL PRIMARY KEY,
	Person_Name varchar(255) NOT NULL,
	Email varchar(255),
	Phone varchar(8),
	Address varchar(255),
	FOREIGN KEY (Address) REFERENCES Addresses(Address),
	Schools varchar(255)
);

CREATE TABLE Stakeholder (
	Person_ID int NOT NULL PRIMARY KEY,
	Stakeholder_Domain varchar(255) NOT NULL,
	FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
	--ON DELETE CASCADE
);

CREATE TABLE Professor (
	Person_ID int NOT NULL,
	Field_of_Expertise varchar(255) NOT NULL,
	CONSTRAINT Professor_Field_Key PRIMARY KEY (Person_ID, Field_of_Expertise),
	FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
	--ON DELETE CASCADE
);

CREATE TABLE Student (
	Person_ID int NOT NULL,
	Student_ID int NOT NULL,
	Admission_Date date, 
	Major_Minor varchar(255) NOT NULL, --DEFAULT ‘NONE’,
	FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID),
	PRIMARY KEY (Student_ID) 
	--ON DELETE CASCADE
);

CREATE TABLE Staff (
	Person_ID int NOT NULL,
	Staff_ID int NOT NULL,
	Date_Hired date,
	Staff_Position varchar(255) NOT NULL,
	FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID),
	PRIMARY KEY (Staff_ID) 
	--ON DELETE CASCADE,
	
);



CREATE TABLE Comment(
	Stakeholder_Person_ID int, 
	Topic varchar(255), 
	Date_Time datetime NOT NULL, 
	FOREIGN KEY (Stakeholder_Person_ID) REFERENCES Person(Person_ID),
	CONSTRAINT Person_Topic_Key PRIMARY KEY (Stakeholder_Person_ID, Topic)
);

CREATE TABLE Course(
	Course_ID int NOT NULL PRIMARY KEY, 
	Course_Name varchar(255) NOT NULL Unique
);


CREATE TABLE Teach( 
	Professor_ID int, 
	Course_ID int, 
	Lesson_Time time, 
	CONSTRAINT Professor_Course_Key PRIMARY KEY(Professor_ID, Course_ID),
	FOREIGN KEY (Professor_ID) REFERENCES Professor(Professor_Field_Key),
	FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Enroll(
	Student_ID int, 
	Course_ID int,
	Enrolment_Date date NOT NULL,
	CONSTRAINT Student_Course_Key PRIMARY KEY (Student_ID, Course_ID),
	FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Graduate(
	Student_ID int NOT NULL, 
	Thesis_Paper varchar(255),
	Professor_ID int NOT NULL, 
	CONSTRAINT Graduate_Prof_Key PRIMARY KEY (Student_ID, Professor_ID),
	FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID), 
	FOREIGN KEY (Professor_ID) REFERENCES Professor(Professor_Field_Key)
);

CREATE TABLE Undergraduate( 
	Student_ID int PRIMARY KEY, 
	GPA float,
	FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);



CREATE TABLE Administrative_Staff(
	Staff_ID int NOT NULL PRIMARY KEY,
	Office_School varchar(255),
	Office_Name varchar(255) 
);

CREATE TABLE Technical_Staff(
	Staff_ID int NOT NULL PRIMARY KEY,
	Lab_School varchar(255),
	Lab_Name varchar(255) 
);

CREATE TABLE Office(
	Office_School varchar(255) NOT NULL,
	Office_Name varchar(255) NOT NULL,
	Lab_School varchar(255),
	Lab_Name varchar(255),
	CONSTRAINT Office_PK PRIMARY KEY(Office_School, Office_Name)
);

CREATE TABLE Laboratory(
	Lab_School varchar(255) NOT NULL,
	Lab_Name varchar(255) NOT NULL,
	Lab_Location varchar(255) NOT NULL,
	CONSTRAINT Lab_PK PRIMARY KEY(Lab_School,Lab_Name),
	UNIQUE(Lab_School),
	UNIQUE(Lab_Name)
);

CREATE TABLE Teaching_Lab(
	Lab_School varchar(255) NOT NULL,
	Lab_Name varchar(255) NOT NULL,
	Subject varchar(255),
	CONSTRAINT TeachLab_PK PRIMARY KEY(Lab_School,Lab_Name),
	FOREIGN KEY (Lab_School, Lab_Name) REFERENCES Laboratory(Lab_School, Lab_Name)
);



CREATE TABLE Research_Lab(
	Lab_School varchar(255) NOT NULL,
	Lab_Name varchar(255) NOT NULL,
	Specialization varchar(255),
	CONSTRAINT ResearchLab_PK PRIMARY KEY(Lab_School,Lab_Name),
	FOREIGN KEY (Lab_School, Lab_Name) REFERENCES Laboratory(Lab_School, Lab_Name)

);

CREATE TABLE Research(
	Research_Topic varchar(255) NOT NULL,
	Lab_School varchar(255) NOT NULL,
	Lab_Name varchar(255) NOT NULL,
	Student_ID int NOT NULL,
	CONSTRAINT Research_PK PRIMARY KEY (Research_Topic, Student_ID),
	FOREIGN KEY (Lab_School, Lab_Name) REFERENCES Research_Lab(Lab_School, Lab_Name),
	FOREIGN KEY (Student_ID) REFERENCES Graduate(Graduate_Prof_Key)
);

CREATE TABLE Experiment(
	Lab_School varchar(255) NOT NULL,
	Lab_Name varchar(255) NOT NULL,
	Student_ID int NOT NULL,
	Experiment_Date date,
	Topic varchar(255),
	CONSTRAINT Experiment_PK PRIMARY KEY (Lab_School, Lab_Name, Student_ID, Experiment_Date),
	FOREIGN KEY (Lab_School, Lab_Name) REFERENCES Teaching_Lab(Lab_School, Lab_Name),
	FOREIGN KEY (Student_ID) REFERENCES Undergraduate(Student_ID)
);

CREATE TABLE Timetable(                    --(weak entity set)
	Course_ID int NOT NULL PRIMARY KEY REFERENCES Course(Course_ID),
	Person_ID int NOT NULL,
	Student_ID int NOT NULL,
	Date_Time datetime,
	If_Clash bit,
	FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	FOREIGN KEY (Person_ID) REFERENCES Professor(Professor_Field_Key)
	--ON DELETE CASCADE
);


CREATE TABLE Equipment (
	Lab_School varchar(255) NOT NULL,
	Lab_Name varchar(255) NOT NULL,
	Equipment_ID int NOT NULL,
	Date_Purchased date NOT NULL,
	Model_No int NOT NULL,
	PRIMARY KEY (Equipment_ID),
	FOREIGN KEY (Lab_School) REFERENCES Laboratory(Lab_School),
	FOREIGN KEY (Lab_Name) REFERENCES Laboratory(Lab_Name)
	--ON DELETE CASCADE
);

CREATE TABLE Models (
	Model_No int NOT NULL ,
	Equipment_Name varchar(255) NOT NULL,
	PRIMARY KEY (Model_No)
);
