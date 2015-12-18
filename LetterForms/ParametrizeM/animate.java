
  /////////////////////////////////////////
  //                                     //
  //  sampling the parameter space ...   //
  //                                     //
  /////////////////////////////////////////

  //  @bitcraftlab 12/2015 (Processing 3.0)

import processing.core.PApplet;
import java.lang.reflect.*;

class Param {
  
  String name;
  float start, max, min, step, val;

  Param(String _name, float _start, float stop, float _step) {
    
    name = _name;
    start = _start;
    step = _step;
    
    // valid range
    max = Float.max(start, stop);
    min = Float.min(start, stop);
    
    val = start;

  }
  
  // sample parameter values, return a carry / overflow bit
  boolean animate() {
    val += step;
    if(val > max || val < min) {
      val = start;
      return true;
    } else {
      return false;
    }
  }
  
}


class Params {
  
  PApplet app;
  Param[] params;
  
  // set debug to true to print the params
  boolean debug;
  
  // using varargs for parameters
  Params(PApplet _app, Param... _params) {
    app = _app;
    params = _params;
    reset();
  }
  
  // reset all params and variables
  void reset() {
    for(int i = 0; i < params.length; i++) {
      params[i].val = params[i].start;
      updateVar(params[i]);
    }
  }
  
  // sample the parameter space
  void animate() {
    animate(0);
    if(debug) {
      app.println(this);
    }
  }

  // nice output of the parameter values
  public String toString() {
    String[] entries = new String[params.length];
    for(int i = 0; i < params.length; i++) {
      entries[i] = params[i].name + ":" + params[i].val;
    }
    return "{" + app.join(entries, ", ") + "}";
  }
  
  void animate(int idx) {
    
    // animate param at the index, possibly getting a carry bit
    boolean carry = params[idx].animate();
    
    // update variable inside the sketch
    updateVar(params[idx]);
    
    // carry one over
    if(carry) {
      if(++idx < params.length) {
        animate(idx);
      }
    }
    
  }
  
  // update variable for a parameter
  void updateVar(Param p) {

     // get field from the app and update it to the parameter value
     try {
       Field f = app.getClass().getDeclaredField(p.name);
       f.set(app, p.val);
     }
     
     // catch all kinds of exceptions
     catch(NoSuchFieldException e) {
       abort("Parameter " + p.name + " not defined");
     }
     catch(IllegalAccessException e) {
       abort("Parameter " + p.name + " not accessible");
     }
     catch(ClassCastException e) {
       abort("Parameter " + p.name + " must be of type float");
     }

     
  }
  
  void abort(String msg) {
    app.println(msg);
    app.println("Aborting.");
    app.exit();  
  }
  
}