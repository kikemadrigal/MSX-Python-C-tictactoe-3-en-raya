char get_number_from_char(char c){
    char number=0;
    switch (c)
    {
      //El 1:
      case 49:
          number=1;
      break;
      //El 2:
      case 50:
          number=2;
      break;  
      //El 3:
      case 51:
          number=3; 
      break;  
      //El 4:
      case 52:
          number=4;
      break;  
      case 53:
          number=5;
      break;
      case 54:
          number=6;
      break;
      case 55:
          number=7;
      break;
      case 56:
          number=8;
      break;
      case 57:
          number=9;
      break;
    }
    return number;
}