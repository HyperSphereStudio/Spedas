/*
   * Author : Johnathan Bizzano
   * Created : Monday, October 23, 2023
   * Last Modified : Monday, October 23, 2023
*/

using System.CodeDom.Compiler;
using System.Text.RegularExpressions;

namespace IDLTranscompiler;

public record Function(string FunctionName, params (string oldName, string newName)[] NameRemap);

public class Transcompiler {
   public static IndentedTextWriter Tw;
   public static Dictionary<string, Function> FunctionMap = new(){
      {"tinterpol", new("sps.tinterpol")},
      {"mms_load_fgm", new("sps.mms.fgm", ("probes", "probe"))},
      {"mms_load_fpi", new("sps.mms.fpi", ("probes", "probe"))},
      {"mms_load_edp", new("sps.mms.edp", ("probes", "probe"))},
      {"mms_cotrans", new("sps.cotrans", ("out_coord", "coord_out"), ("in_coord", "coord_in"))},
      {"add_data", new("tplt.add", ("newname", "new_tvar"))},
      {"get_data", new("sps.get_data", ("newname", "new_tvar"))},
      {"mult_data", new("tplt.multiply", ("newname", "new_tvar"))},
      {"div_data", new("tplt.divide", ("newname", "new_tvar"))},
      {"store_data", new("tplt.store_data")},
      {"split_vec", new("tplt.split_vec")},
      {"options", new("tplt_options")},
      {"tplot", new("tplt.tplot")},
      {"mms_lingradest", new("sps.mms.lingradest")},
      {"ylim", new("tplt.ylim")},
      {"timestamp", new("tplt.timestamp")}
   };

   public static void Compile(string fileIn, string fileOut) {
      Tw = new IndentedTextWriter(new StreamWriter(new FileStream(fileOut, FileMode.Create)));
      
      Tw.WriteLine(@"import pyspedas as sps, numpy as np, math
import pytplot as tplt

#Helper Functions

def tplt_options(name, **kwargs):
    tplt.options(name, opt_dict=kwargs)

def tplotbroadcast(f, names, newname):
    datas = [tplt.get_data(n).y for n in names] 
    tplt.store_data(newname, data={'x': tplt.get_data(names[0]).times, 'y': [f(i, datas) for i in range(len(datas[0]))]})
    return newname");
      
      foreach (var l in File.ReadAllLines(fileIn)) {
         var str = l.Replace(@",", ", ").Replace(",\\w+", ", ");
        
         if (str.StartsWith(';')) {
            str = str.Replace(';', '#');
         }else{
            foreach (var name in FunctionMap) {
               if (str.StartsWith(name.Key)) {
                  str = str.Remove(0, name.Key.Length + 1).Trim();
                  Tw.Write(name.Value.FunctionName);
                  Tw.Write('(');
                  
                  str = new Regex("/([A-Za-z0-9_]+)").Replace(str, "$1=True");
                  foreach (var k in name.Value.NameRemap)
                     str = str.Replace(k.oldName, k.newName);
                  
                  Tw.Write(str);
                  Tw.WriteLine(')');
                  goto bottom;
               }
            }
         }
         str = str.Replace(';', ' ');
         Tw.WriteLine(str);
         bottom: ;
      }
      
      Tw.Flush();
   }
}