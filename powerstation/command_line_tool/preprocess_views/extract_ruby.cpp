#include<stdio.h>

#include <iostream>
#include <string>
int main(int argc, char** argv){
	
	if (argc != 3){
		printf("Usage: extract_ruby input output\n");
		return 1;
	} 
    
  char *input_file = argv[1], *output_file = argv[2];
  std::string str = "";
  str += output_file;
  str += ".line";
  FILE* fin = fopen(input_file, "rb");
  FILE* fout = fopen(output_file, "wb");
  FILE* lineout = fopen(str.c_str(), "wb");
  int line = 1;
  int cl = 1;
  char a = fgetc(fin), b = fgetc(fin), c = fgetc(fin);
  if(a == '\n')
    line += 1;
  while (a != EOF){
    if (a == '<' && b == '%'){
      if (c == '=' || c == '-'){
        a = fgetc(fin);
        b = fgetc(fin);
        c = fgetc(fin);
        if(a == '\n'){
          std::string result = std::to_string(line) + " 1" + '\n';
          fputs(result.c_str(), lineout);
          line += 1;
          cl += 1;
        }
        while ((a != '%' || b != '>') && (a != '-' || b != '%' || c != '>')){
          fputc(a, fout);
          a = b;
          b = c;
          c = fgetc(fin);      
          if(a == '\n'){
            std::string result = std::to_string(line) + " 1" + '\n';
            fputs(result.c_str(), lineout);
            line += 1;
            cl += 1;
          }
        }   
        
        fputc('\n', fout);
        std::string result = std::to_string(line) + " 1" + '\n';
        fputs(result.c_str(), lineout);
        cl += 1;
        
        if (c != '>') 
          a = c;
        else 
          a = fgetc(fin);
        if(a == '\n')
            line += 1;

        b = fgetc(fin);
        c = fgetc(fin);
      } else if (c == '#') {
        b = c;
        a = b;
        c = fgetc(fin);
        if(a == '\n')
          line += 1;
        
      } else {
        a = c;
        b = fgetc(fin);
        c = fgetc(fin);
        if(a == '\n'){
          std::string result = std::to_string(line) + " 1" + '\n';
          fputs(result.c_str(), lineout);
          line += 1;
          cl += 1;
        }
        while ((a != '%' || b != '>') && (a != '-' || b != '%' || c != '>')){
          fputc(a, fout);
          a = b;
          b = c;
          c = fgetc(fin);
          if(a == '\n'){
            std::string result = std::to_string(line) + " 0" + '\n';
            fputs(result.c_str(), lineout);
            line += 1;
            cl += 1;
          }

        }   
        fputc('\n', fout);
        std::string result =  std::to_string(line) + " 0" + '\n';
        fputs(result.c_str(), lineout);
        cl += 1;
        if (c != '>')
          a = c;
        else 
          a = fgetc(fin);
          
        if(a == '\n')
            line += 1;
        b = fgetc(fin);
        c = fgetc(fin);
      }
    } else {
      a = b;
      b = c;
      c = fgetc(fin); 
      if(a == '\n')
          line += 1;
    }
  }
  
  fclose(fin);
  fclose(fout);
  fclose(lineout);
}
