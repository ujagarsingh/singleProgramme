<script>
	var old_obj = [
		{inning_name: "First Inning", inning_time : "8:30 AM to 11:00 AM", subject : "Hindi"},
		{inning_name: "Second Inning", inning_time : "2:30 PM to 5:00 PM", subject : "English"}
	] ;
	var new_obj = [
		{inning_name: "First Inning", inning_time : "8:30 AM to 11:00 AM"},
		{inning_name: "Second Inning", inning_time : "2:30 PM to 5:00 PM"},
		{inning_name: "Third Inning", inning_time : "8:30 PM to 11:00 PM"}
	]
	
	function updateInnings(){
		
		const final_obj = new_obj.map((item) => {
			let subject = '';
			old_obj.forEach((item_o) => {
				if(item.inning_name == item_o.inning_name){
					subject = item_o.subject;
				} 
			})
			
			return item = {...item, subject : subject};
			
		})
		console.log(final_obj);
	}
	
	const result = updateInnings();
</script>
