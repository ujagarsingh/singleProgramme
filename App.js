INSERT INTO beautiful (name, age)
    VALUES
		('Helen', 24),
		('Katrina', 21),
		('Samia', 22),
		('Hui Ling', 25),
		('Yumie', 29)
	ON DUPLICATE KEY UPDATE
		age = VALUES(age),
		 ...
		-----------------------------------------
	$query = "INSERT INTO 
		" . $this->table_name . " 
			(class_id, exam_id, sub_id, marks_obtain, admission_number) VALUES "; //Prequery
			
	$qPart = array_fill(0, count($this->student_obj), "(?, ?, ?, ?, ?)");
	$query .=  implode(",",$qPart);
	$query .= "ON DUPLICATE KEY UPDATE
				class_id = VALUES(class_id), 
				exam_id = VALUES(exam_id), 
				sub_id = VALUES(sub_id),
				admission_number = VALUES(admission_number),
				marks_obtain = VALUES(marks_obtain)";
