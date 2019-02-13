{ 
   if (substr($4,1,7)=="create ") {
      if (substr($5,1,4)=="from") {
         if (index($9,"::")>0) {
            print $4 "\n   " $9 "\nfrom ( \n   select\n      " $7 "\n   " $5 "); \n\n";;
         }
         else {
            print $4 "\n      " $7 "\n   " $5 "; \n\n";
         }
      }
      else {
         create_clause=$4
         outer_select=sprintf("   %s",$9);
         inner_select=sprintf("      %s",$7);
      }
   } else if (substr($5,1,4)=="from") {
      print create_clause;
      if (index(outer_select,"::")>0) {
         print outer_select "\n   ," $9 "\nfrom ( \n   select";
         print inner_select "\n      ," $7 "\n   " $5 "); \n\n";
      }
      else {
         print inner_select "\n      ," $7 "\n   " $5 "; \n\n";
      }
   } else if (index($7,"::")>0) {
      outer_select=sprintf("%s\n   ,%s",outer_select,$9);
      inner_select=sprintf("%s\n      ,%s",inner_select,$7)
   }   
}
