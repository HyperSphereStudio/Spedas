
;+
;  generic_object
;  This basic object can be inherited by other objects and defines some basic functions and operations
; $LastChangedBy: davin-mac $
; $LastChangedDate: 2018-12-08 09:36:55 -0800 (Sat, 08 Dec 2018) $
; $LastChangedRevision: 26279 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/tags/spedas_5_0/general/misc/generic_object__define.pro $
;
; Written by Davin Larson October 2018
;-




pro generic_object::help
  help,self,/obj
end


function generic_object::printdat_string,full=full
  COMPILE_OPT IDL2
  outstr = !null
  strct = create_struct(name=typename(self))
  struct_assign , self, strct
  tags = tag_names(strct)
  ignoretags = tag_names({idl_object})
  for i=0,n_elements(tags)-1 do begin
    if array_equal(ignoretags,tags[i],/not_equal) then begin
      printdat,varname=tags[i],self.getattr(tags[i]), output =str
      outstr = [outstr,str]     
    endif
  endfor  
  return,outstr
END



PRO generic_object::SetProperty, _extra=ex
  COMPILE_OPT IDL2
  ; If user passed in a property, then set it.
  if keyword_set(ex) then begin
    struct_assign,ex,self,/nozero,/verbose
  endif
END




;PRO generic_object::GetProperty, _ref_extra = ex
;  COMPILE_OPT IDL2
;  strct = create_struct(name=typename(self))
;  struct_assign , self, strct
;
;  printdat,ex
;  printdat,strct
;  str_element,strct,ex[0],value
;  printdat,value
;;  self.help
;END




function generic_object::GetAttr, name, default = value
  COMPILE_OPT IDL2
  strct = create_struct(name=typename(self))
  struct_assign , self, strct
  if isa(name,/string) eq 0 then return,strct
  str_element,strct,name,value
  return,value
END

PRO generic_object::Cleanup
  COMPILE_OPT IDL2
  ; Call our superclass Cleanup method
  dprint,verbose =self.verbose ,dlevel=self.dlevel+1,'Cleanup of  '+typename(self)
  self->IDL_Object::Cleanup
END



function generic_object::init,verbose=verbose,dlevel=dlevel,_extra=ex
;  void = self->IDL_Object::Init()
  if isa(dlevel) then  self.dlevel=dlevel else self.dlevel=2
  if isa(verbose) then self.verbose = verbose else self.verbose = 2
  IF (ISA(ex)) THEN self->SetProperty, _EXTRA=ex
  ;  dprint,'Init',dlevel=self.dlevel
  dprint,verbose=self.verbose,dlevel=self.dlevel+1,'Initialization of '+typename(self)
  return,1
end




pro generic_object__define
  void = { generic_object, $
    inherits IDL_Object, $ ; superclass
    verbose: 0, $
    dlevel: 0  $
  }
end


