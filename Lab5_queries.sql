--1. Find all stakeholders who belong to the public domain. 

SELECT X.Person_ID, Y.Person_Name
FROM Stakeholder as X, Person as Y
WHERE X.Person_ID = Y.Person_ID AND Stakeholder_Domain = 'Public';

--2. Find all stakeholders who have provided at least five comments or suggestions. 

SELECT X.Person_ID
FROM Stakeholder as X, Comment as Y
WHERE X.Person_ID = Y.Stakeholder_Person_ID
GROUP BY X.Person_ID
HAVING COUNT(X.Person_ID) = 5


--3. Find graduates who are supervised by more than one professors and assigned to more than one research laboratories.

SELECT X.Student_ID
FROM Graduate as X, Professor as Y, Research as Z
WHERE X.Professor_ID = Y.Person_ID 
AND X.Student_ID = Z.Student_ID
GROUP BY X.Student_ID
HAVING COUNT(X.Student_ID)  1 AND COUNT(Z.Lab_Name)  1


--4. Find all professors who teach more than one courses in the semester. 

SELECT X.Person_ID
FROM Professor as X, Person as Y, Teach as Z
WHERE Z.Professor_ID = X.Person_ID
AND X.Person_ID = Y.Person_ID
GROUP BY X.Person_ID
HAVING COUNT(Z.Course_ID)  1


--5. List all the equipment belonging to a particular laboratory.
 
--if let’s say it’s Software Lab 1 in SCSE

SELECT  
FROM Equipment as X, Models as Y
WHERE X.Model_No = Y.Model_No
AND X.Lab_Name = 'Software Lab 1'
AND X.Lab_School = 'SCSE'


--6. Find all undergraduates who have not attended at least one laboratory experiments. 

SELECT Undergraduate.Student_ID
FROM Experiment, Undergraduate 
WHERE NOT Undergraduate.Student_ID = Experiment.Student_ID;
			

--7. List all graduates who are doing research and taking courses in the semester.

SELECT DISTINCT Graduate.Student_ID
FROM Graduate, Research, Enroll
WHERE Graduate.Student_ID = Research.Student_ID
AND Graduate.Student_ID = Enroll.Student_ID
AND Enroll.Course_ID IS NOT NULL
