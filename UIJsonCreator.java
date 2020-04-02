package com.sagipl.aaaaonlytest;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.ParseSettings;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;

public class UIJsonCreator{

	public static void main(String[] args) throws IOException {
		
		File folder = new File("D:\\ui");
		
		getFilesAndFolders(folder);
		
		System.out.println("+++++++++++++++++++++ Done!!! +++++++++++++++++++++++");
	}
	
	// Manipulate files with id, tooltip, translate='key' and 
	// create new json file for tooltip and traslate 
	public static void generateJsonAndReWriteFiles(String sorceFile, String fileName) {
		 BufferedWriter  writer = null;
		 String file_name = fileName;
	      try	            
	      {
	    	  Parser parser = Parser.htmlParser();
	    	  parser.settings(new ParseSettings(true, true));
	    	  System.out.println(sorceFile);
	    	  String htmlString="";
	    	  String tmpStr="";
	    	  BufferedReader fr=new BufferedReader(new FileReader(new File(sorceFile)));
	    	  while((tmpStr=fr.readLine())!=null) {
	    		  htmlString += tmpStr;
	    	  }
	    	  Document document = parser.parseInput(htmlString,"");//, "utf-8");
	    	  
	    	  //Document document = Jsoup.parse(new File(sorceFile), "utf-8");
	          
	          String[] strArray = new String[] {"label","button","select","a[href]","input[type=text]","input[type=check]","input[type=radio]"};
	          
	          for(int x=0; x < strArray.length; x++) {
	        	
		          Elements links = document.select(strArray[x]);
		          String sellector = strArray[x];
		          
		          // get last Id of elements if has in all ready. 
		          int last_id = getLastIdofElements(links) + 1;
		          // System.out.println("Last Id  __ : " + last_id);
		          
		          for(int i = 0; i < links.size(); i++) {
		        	  int id_val = last_id + i;
		        	  requiredAction(links.get(i), sellector, i, id_val);
		          }
	          
	          }
	          
	          
	          File f = new File(sorceFile);
	          
	          
	          String folderPath = f.getParent(); 
	          String targetPath = "";
	          //String fileName = f.getName();
	          if(folderPath.contains("D:\\ui\\code")){
	        	  targetPath = folderPath.replace("D:\\ui\\code", "");
	          } else {
	        	  targetPath = folderPath.replace("D:\\ui\\assets", "");
	          }
	          String alternative = targetPath.replace('\\', '/');
	          
	          directoryAssurance("D:/ui//assets"+ alternative);
	          // if save in same folder
	          String html_source_Path = "D:/ui/code"+ alternative + "/";
	          String json_target_Path = "D:/ui/assets"+ alternative + "/";
	          String final_with_fileName = "D:/ui/code"+ alternative + "/"+file_name;
	          
	          writer = new BufferedWriter( new FileWriter(final_with_fileName));
	          //writer.write(document.html());
	          writer.write(document.body().html());
	          writer.close();
	          
	          // CREATE JSON FILE FOR DATABASE 
	          System.out.println("html_source_Path :"+html_source_Path);
	          System.out.println("json_target_Path :"+ json_target_Path);
	          System.out.println("file_name :"+ file_name);
	          createTransJsonHandler(html_source_Path, json_target_Path, file_name);
	          
	      } 
	      catch (IOException e) 
	      {
	          e.printStackTrace();
	      }
	};
	
	// get all folder's and file's name including subfolder's
	public static void getFilesAndFolders(File directoryName) {
		
		File[] listOfFiles = directoryName.listFiles();
		
		// System.out.println("list of files " + Arrays.toString(listOfFiles));
		
		if(listOfFiles != null) {
		for (int i = 0; i < listOfFiles.length; i++) {
		  String path = listOfFiles[i].getAbsolutePath();
		  
		  if (listOfFiles[i].isFile()) {
			String fileExt = listOfFiles[i].getName();
			if(fileExt.endsWith(".html")) {
				String fileName = listOfFiles[i].getName(); 
				
				// System.out.println("File " + fileName);
				// System.out.println(path);
				
				generateJsonAndReWriteFiles(path, fileName);
			}
		  } else if (listOfFiles[i].isDirectory()) {
			 System.out.println("Directory " + listOfFiles[i].getName());
		     
			 // String path = listOfFiles[i].getAbsolutePath();
		     File folder = new File(path);
		     
		     getFilesAndFolders(folder);
		  }
		}
	    
	 }
	}

	public static int getLastIdofElements(Elements allElement) {
		
		int last_id = 0;
		String elem_id;
		for(int i=0; i < allElement.size(); i++) {
			allElement.get(i);
			//System.out.println("elemet __ : " + allElement.get(i));
			elem_id = allElement.get(i).attr("id");
			
			if(elem_id.length() > 0) {
				//  System.out.println("text __ : " + elem_id);
				if(elem_id.contains("_usrx_")) {
					String[] arrSplit = elem_id.split("_usrx_");
					// System.out.println("numeric  __ : " + arrSplit[1]);
					int val = Integer.parseInt(arrSplit[1]);
					if(val > 0) {
						// System.out.println("numeric  __ : " + val);
						if(last_id < val) {
							last_id = val;	
						}
						
					}
				}
			}
        }
		return  last_id;
	}
	
	/** Creates or Check Drectory Structure  */
	private static void directoryAssurance(String directory) {
		// String path = createImages.getAbsolutePath() + "/Images";
		File f = new File(directory);
		if (!f.isDirectory()) {
		  boolean success = f.mkdirs();
		  if (success) {
		    System.out.println("Created path: " + f.getPath());
		  } else {
		    System.out.println("Could not create path: " + f.getPath());
		  }
		} else {
		  System.out.println("Path exists: " + f.getPath());
		}
	}
	
	// create required action
	public static void requiredAction(Element elem, String tagName, int i, int id_val) {

		// int 	inx_no = i;
		
		String 	inx_xt;
		if(tagName == "select") {
			inx_xt = getLabelTextForSelectBox(elem).trim();
		} else {
			inx_xt = getInnerText(elem).trim();
		}
		
		String 	inx_id = elem.attr("id").trim();
		String 	i_trns = elem.attr("[translate]").trim();
		String 	in_tip = elem.attr("tooltip").trim();
		// String 	inx_cl = elem.attr("class");
		// boolean	is_cls = elem.hasClass("hellow");
		
		/*
		System.out.println("Element       : " + elem );
		System.out.println("Index         : " + i);
		System.out.println("Text          : " + elem.ownText());
		System.out.println("Id            : " + elem.attr("id"));
		System.out.println("TagName       : " + elem.attr("class"));
		System.out.println("HasClass      : " + elem.hasClass("hellow"));
		System.out.println("Tag           : " + tagName);
		System.out.println("-----------------------------------------------------");
		*/

		switch(tagName) {
		  case "a[href]":
		    // code block
			  if(inx_id.length() == 0) {
				  elem.attr("id", "anc_usrx_"+id_val);
			  }
			  if( inx_xt.length() != 0) {
				  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
			  }
		    break;
		  case "label":
		    // code block
			  if(inx_id.length() == 0) {
				  elem.attr("id", "lbl_usrx_"+id_val);
			  }
			  if( inx_xt.length() != 0) {
				  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
			  }
		    break;
		  case "button":
		    // code block
			  if(inx_id.length() == 0) {
				  elem.attr("id", "btn_usrx_"+id_val);
			  }
			  if( inx_xt.length() != 0) {
				  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
			  }
		    break;
		  case "select":
			    // code block
				  if(inx_id.length() == 0) {
					  elem.attr("id", "slt_usrx_"+id_val);
				  }
				  if( inx_xt.length() != 0) {
					  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
				  }
			    break;
		  case "input[type=text]":
		    // code block
			  if(inx_id.length() == 0) {
				  elem.attr("id", "ipt_usrx_"+id_val);
			  }
//			  if( inx_xt.length() != 0 && inx_xt != null) {
//				  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
//			  }
		    break;
		  case "input[type=check]":
		    // code block
//				  if(inx_id.length() == 0) {
//					  elem.attr("id", "ipc_usrx_"+id_val);
//				  }
		  	if( inx_xt.length() != 0) {
				  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
			  }
		    break;
		   case "input[type=radio]":
		    // code block
//				  if(inx_id.length() == 0) {
//					  elem.attr("id", "ipr_usrx_"+id_val);
//				  }
		   	  if( inx_xt.length() != 0) {
				  writeTransTool(inx_xt, i_trns, in_tip, elem, tagName);
			  }
		    break;
		  default:
		    // code block
			  System.out.println("++++++++++++++++++ Something is Wrong!!!!!!! ++++++++++++++++");
		}
		
	}

	public static String getInnerText(Element elem){
		
		Element current_elem = elem;
		String text_label = current_elem.ownText().trim();
		String label_text = "";
		
		if(text_label.length() > 0) {
			label_text = text_label;
		} else {
			Elements crnt_elems = current_elem.children();
			
			for(int x = 0; x < crnt_elems.size() ; x++) {
				if(text_label.length() > 0){
					label_text = text_label + "_" +  crnt_elems.get(x).ownText().trim();
				} else {
					label_text = text_label + crnt_elems.get(x).ownText().trim();
				}
	        }
		}
		return label_text;
	}

	public static String getLabelTextForSelectBox(Element elem){
		
		String text_label = "";
		Element current_elem = elem;
		
		try
	      {
			if(current_elem.hasClass("form-group")) {
				String html = current_elem.toString();
				Document doc = Jsoup.parse(html);
				
				Elements label = doc.select("label");
				if(label.size() > 0 ) {
					text_label = label.get(0).ownText();
					System.out.println(text_label);
				} else {
					text_label = "Label NAF!!";
				}
				return text_label;
			} else {
				Element crnt_elem = current_elem.parent();
				return getLabelTextForSelectBox(crnt_elem);
			}
	      } 
	      catch (Exception e) 
	      {
  	          // e.printStackTrace();
	          System.out.println("Select Box in the table area.!!");
	          
	          return "Label Table NAF!!";
	      }
		
	}
	
	// write json  
	@SuppressWarnings("unchecked")
	// inx_xt, i_trns, in_tip, elem
	public static void writeTransTool(String elem_text, String transText, String toolText, Element input_elem, String tagname){
		
		JSONObject oldLangList = null;
		JSONObject oldToolList = null;
		// JSONObject langObject = new JSONObject();
		// JSONObject mergeObject = new JSONObject();
		oldLangList = readJson("D:/ui/assets/translate_key.json");
		oldToolList = readJson("D:/ui/assets/tooltip_key.json");
		System.out.println("tagname_____++++___         "+ tagname);
		Element elem = input_elem;
		String innerText = (String) elem_text.trim();
		
		// IF ELEMENT IS CHECK OR RADIO THAN APPLY TOOLTIP AND 
		// LANGULAGE TRANSLATOR IN PARENT DIV ELEMENT 
		if(tagname.equals("input[type=check]") && tagname.equals("input[type=radio]")) {
			elem = input_elem.parent();
		}
		
		if(tagname.equals("select")) {
			innerText = (String) getLabelTextForSelectBox(elem);
		}
		
		// EXCEPTION HANDLER  
		// IF OBJECT NOT HAVE ANY KEY
		try {
			Set<JSONObject> all_keys_trans = oldLangList.keySet();
			Set<JSONObject> all_keys_toolt = oldToolList.keySet();
			
			// JSONObject langList = new JSONArray();
		   	String trans_str = "";		// Translate Value
		   	String current_key_trans = "";	// current key translate
		   	String current_key_toolt = "";	// current key tooltip
		   	boolean isAllreadyTrans = false;
		   	boolean isAllreadyToolt = false;
		   		
		   		 
		   		// for Translate
		        for (Object key : all_keys_trans) {
		        	System.out.println("json_key_tr             " + key);
		        	System.out.println("json_value_tr           " + oldLangList.get(key));
		        	System.out.println("new_text_tr             " + innerText);
				 
		        	if((innerText).equalsIgnoreCase(((String) oldLangList.get(key)))) {
		        		current_key_trans = (String) key;
		        		isAllreadyTrans = true;
		        		break;
		        	} 
		        	  else {
		        		System.out.println("else aflatoon");
		        	}
		        }
		        
		        // for Tooltip
		        for (Object key : all_keys_toolt) {
		        	System.out.println("json_key_tt             " + key);
		        	System.out.println("json_value_tt           " + oldToolList.get(key));
		        	System.out.println("new_text_tt             " + innerText);
		        	
		        	System.out.println("___________             " + elem.hasAttr("tooltip"));
		        	
		        	/* !elem.hasAttr("tooltip") */
		        	if(elem.hasAttr("tooltip")) {
			        	String elem_trans_attr = elem.attr("tooltip");
			        	String elem_trans_arr []= elem_trans_attr.split("'");
			        	System.out.println("___________             " + elem_trans_arr[1]);
		        	 
			        	if((elem_trans_arr[1]).equalsIgnoreCase(((String) key))) {
			        		current_key_toolt = (String) key;
			        		isAllreadyToolt = true;
			        		break;
			        	} else {
			        		System.out.println("else aflatoon");
			        	}
		        	}
		        	 
		        }
		   		 
		   		
		        /* Translate Start ----------------------------------------------------------------------------------------- */
		        if(!isAllreadyTrans){
		        	// current_key = String.valueOf(all_keys.size()+1);
		        	current_key_trans = String.valueOf(getLargest(all_keys_trans));
		        	
		        	System.out.println("current keys trans         "+ current_key_trans);
		        	System.out.println("all keys trans             "+ all_keys_trans);
		        	System.out.println("Next keys trans            "+ getLargest(all_keys_trans)); ;
		        	// for new data
		        	oldLangList.put(current_key_trans, innerText);
		        	// System.out.println("oldLangList_____++++___"+ oldLangList);
					//Write JSON file
		 	        try (FileWriter file = new FileWriter("D:/ui/assets/translate_key.json")) {
		 	            file.write(oldLangList.toJSONString());
		 	            file.flush();
		 	 
		 	        } catch (IOException e) {
		 	            e.printStackTrace();
		 	        }
		        } 
				
				// apply translate is not applied				
	 			if(transText.length() == 0) {
	 				trans_str = "'"+current_key_trans+"'";
	 				elem.attr("[translate]", trans_str);
	 			}
	 			/* Translate End ----------------------------------------------------------------------------------------- */
	 			
	 			/* ToolTip Start ----------------------------------------------------------------------------------------- */
	 			if(!isAllreadyToolt){
		        	// current_key = String.valueOf(all_keys.size()+1);
		        	current_key_toolt = String.valueOf(getLargest(all_keys_toolt));
		        	
		        	System.out.println("current keys toolt         "+ current_key_toolt);
		        	System.out.println("all keys toolt             "+ all_keys_toolt);
		        	System.out.println("Next keys toolt            "+ getLargest(all_keys_toolt)); ;
		        	// for new data
		        	oldToolList.put(current_key_toolt, innerText);
		        	// System.out.println("oldLangList_____++++___"+ oldLangList);
					//Write JSON file
		 	        try (FileWriter file = new FileWriter("D:/ui/assets/tooltip_key.json")) {
		 	            file.write(oldToolList.toJSONString());
		 	            file.flush();
		 	 
		 	        } catch (IOException e) {
		 	            e.printStackTrace();
		 	        }
		        } 
				
	 			// apply tooltip is not applied
	 			if(toolText.length() == 0) {
	 				String tootip_str = "{{ '"+current_key_toolt+"' | translate }}";
	 				elem.attr("tooltip", tootip_str);
	 			}
	 			/* ToolTip End ----------------------------------------------------------------------------------------- */
	 			
			}
			catch (Exception e) 
			{
				 //  e.printStackTrace();
				 System.out.println("+++++++++++++++++++++ OldJSON have wrong !! +++++++++++++++++++++++");
			}
       
    }
	
//	public static JSONObject mergeJSONObjects(JSONObject json1, JSONObject json2) {
//		JSONObject mergedJSON = new JSONObject();
//		System.out.println(json1);
//		System.out.println(json2);
//		
//		json1.keySet(); //
//		
//		
//	}
	
	
	// Largest Key 
	public static <T> int getLargest(Set<JSONObject> allKeys){
		int myKeys[] = new int[allKeys.size()];
		int x = 0;
		
		for (Object key : allKeys) {
		  myKeys[x] = Integer.parseInt((String) key);
		  x++;
		}; 

//		if((innerText.toUpperCase()).equalsIgnoreCase(
//	       			((String) oldLangList.get(key)).toUpperCase())) {
//	       		current_key = (String) key;
//	       		isAllready = true;
//	       		break;
//	       	} else {
//	       		System.out.println("else aflatoon");
//	       	}
//	    }
		  
		  int size = myKeys.length;
		  Arrays.sort(myKeys);
		  // System.out.println("sorted Array ::"+Arrays.toString(allKeys));
		  int res = myKeys[size - 1] + 1;
		  // System.out.println("largest element is ::"+ res);
		  return res;
		}  
	
	public static JSONObject readJson(String filePath) {
        //JSON parser object to parse read file
        JSONParser jsonParser = new JSONParser();
        Object langList = null;
        try (FileReader reader = new FileReader(filePath))
        {
            //Read JSON file
            Object obj = jsonParser.parse(reader);
            
            // System.out.println(obj);
            langList =  obj;
            // System.out.println(langList);
            
            //Iterate over employee array
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("+++++++++++++++++++++ translate_key.json file is Blank! +++++++++++++++++++");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("+++++++++++++++++++++ translate_key.json file is Blank!! +++++++++++++++++++");
        } catch (org.json.simple.parser.ParseException e) {
			// e.printStackTrace();
			System.out.println("+++++++++++++++++++++ translate_key.json file is Blank!!! +++++++++++++++++++");
		}
        return (JSONObject) langList;
    }
	
	@SuppressWarnings("unchecked")
	public static void createTransJsonHandler(String sourcePath, String targetPath, String fileName) {
		  BufferedWriter  writer = null;
	      try
	      {
	    	  Document document = Jsoup.parse(new File(sourcePath + fileName), "utf-8");
	          
	          String[] strArray = new String[] {"label","select","input","check","radio","button"};
	          
	          JSONObject main_json = new JSONObject();
	          
	          for(int x=0; x < strArray.length; x++) {
	        	
		          Elements links = document.select(strArray[x]);
		          // String sellector = strArray[x];
		          
		          // GET ALL JSON OF ONE TYPE
		          JSONArray json_values = getIdofElementsTrans(links);
		          // System.out.println(json_values);
		          main_json.put(strArray[x], json_values);
		          // System.out.println(main_json);
	          }
	          
	          
	          JSONObject controlsJson = new JSONObject();
	          controlsJson.put("controls", main_json);
	          controlsJson.put("pagename", "page_name");   
	          
	          JSONObject psgeJson = new JSONObject();
	          psgeJson.put("pageInfo", controlsJson);
	          
	          String[] arrSplit = fileName.split(".html");
	          
	          String finalFilePath_json = targetPath + arrSplit[0]+".json";
	          
	          writer = new BufferedWriter( new FileWriter(finalFilePath_json));
	          writer.write(psgeJson.toJSONString());
	          writer.close();
	           
	      } 
	      catch (IOException e) 
	      {
	          e.printStackTrace();
	      }
	}
	 
	
	@SuppressWarnings("unchecked")
	public static JSONArray getIdofElementsTrans(Elements links){
		JSONArray all_keys =  new JSONArray();
		
		for(int x=0; x < links.size(); x++) {
			  JSONObject single_keys =  new JSONObject();
	          Element sellector = links.get(x);
	          String crntNode = sellector.nodeName();
	          String id_key = sellector.attr("id");
	          String inner_text ="";
	          if(crntNode == "select") {
	        	 inner_text = getLabelTextForSelectBox(sellector);
	          } else if(crntNode == "button") {
		        	 inner_text = getInnerText(sellector);
		      } else {
	        	 inner_text = sellector.ownText();
	          }
	          single_keys.put("id", id_key);
	          single_keys.put("text", inner_text);
	          all_keys.add(single_keys);
	          // System.out.println(id_key);
        }
		
		return all_keys;
	}
	
	
}
