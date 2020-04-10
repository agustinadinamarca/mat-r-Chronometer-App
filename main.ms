
// https://imgur.com/GAfCkH5.png  play
// https://imgur.com/7M3WrUa.png flag
// https://imgur.com/1lVjUJM.png pause
// https://imgur.com/AlVmYeN.png reset

Experience Main {
    String time as Label
    String img_1 as Image
    String img_2 as Image
    String img_3 as Image
    Array<String> tms value([]) as List
    Array<flagTime> ft value([])
}

Model flagTime{
    Integer ms
    Integer s
    Integer m
    Integer h
}

Application {
    Main exp
    Double sec
    Integer count
    Integer num_ms
    Integer num_s
    Integer num_m
    Integer num_h
    
    Timer t
    Timer tt
    Timer ttt
    Timer tttt
    
    OnInit {
        num_s = 0
        num_ms = 0
        num_m = 0
        num_h = 0
        count=1

        exp = Main()
        exp.time = "00:00:00:00"
        exp.img_1 = "https://imgur.com/GAfCkH5.png"
        exp.img_2 = ""
        exp.img_3 = ""
        
        t = Timer(delay:0.05, function: @function(MainModule.start), repeat: true)
        tt = Timer(delay:0.05, function: @function(MainModule.change1), repeat: false)
        ttt = Timer(delay:0.05, function: @function(MainModule.change2), repeat: false)
        tttt = Timer(delay:0.05, function: @function(MainModule.change3), repeat: false)
        
        broker.ui.push("Main", exp)
    }
}

RuleContext MainContext {
    Rule start {
        t.start()
        exp.img_1= ""
        exp.img_2= "https://imgur.com/7M3WrUa.png" //flag
        exp.img_3= "https://imgur.com/1lVjUJM.png" //pause
    }
    
}

Module MainModule {
    void func1(Main e) {
        if(e.img_3=="https://imgur.com/1lVjUJM.png"){  //pausa
            t.stop()
            tt.start()
        }
        
        if(e.img_3=="https://imgur.com/GAfCkH5.png"){ //play
            t.start()
            ttt.start()
        }
        
    }
    
    void func2(Main e){
        if(e.img_2=="https://imgur.com/7M3WrUa.png"){//flag
        
            flagTime b = flagTime()
            b.ms=num_ms
            b.s=num_s
            b.h=num_h
            b.m=num_m
            exp.ft.add(b)
            
            String m11 = b.ms.toString()
            String m2 = b.s.toString()
            String m3 = b.m.toString()
            String m4 = b.h.toString()
        
            if(m11.length()<2){
                m11 = "0"+m11
            }
            
            if(m2.length()<2){
                m2 = "0"+m2
            }
            
            if(m3.length()<2){
                m3 = "0"+m3
            }
            
            if(m4.length()<2){
                m4 = "0"+m4
            }
            

            if(count.toString().length()<2){
                if(count==1){
                    Integer a = exp.tms.unshift("0"+count.toString()+"      "+"+ "+m4+":"+m3+":"+m2+"."+m11+"      "+m4+":"+m3+":"+m2+"."+m11)
                }else{
                    flagTime g = exp.ft.get(exp.ft.size()-2)
                    Integer ms1 = b.ms-g.ms
                    Integer s1 = b.s-g.s
                    Integer m1 = b.m-g.m
                    Integer h1 = b.h-g.h
                    if(ms1<0){
                        ms1=-ms1
                    }
                    if(s1<0){
                        s1=-s1
                    }
                    if(m1<0){
                        m1=-m1
                    }
                    if(h1<0){
                        h1=-h1
                    }
                    String f1 =ms1.toString()
                    String f2 = s1.toString()
                    String f3 = m1.toString()
                    String f4= h1.toString()
                    
                    if(f1.length()<2){
                        f1 = "0"+f1
                    }
                    
                    if(f2.length()<2){
                        f2 = "0"+f2
                    }
                    
                    if(f3.length()<2){
                        f3 = "0"+f3
                    }
                    
                    if(f4.length()<2){
                        f4 = "0"+f4
                    }
            
                    Integer a = exp.tms.unshift("0"+count.toString()+"      "+"+ "+f4+":"+f3+":"+f2+"."+f1+"      "+m4+":"+m3+":"+m2+"."+m11)
                }
            }else{
                    flagTime g = exp.ft.get(exp.ft.size()-2)
                    Integer ms1 = b.ms-g.ms
                    Integer s1 = b.s-g.s
                    Integer m1 = b.m-g.m
                    Integer h1 = b.h-g.h
                    if(ms1<0){
                        ms1=-ms1
                    }
                    if(s1<0){
                        s1=-s1
                    }
                    if(m1<0){
                        m1=-m1
                    }
                    if(h1<0){
                        h1=-h1
                    }
                                        String f1 =ms1.toString()
                    String f2 = s1.toString()
                    String f3 = m1.toString()
                    String f4= h1.toString()
                    
                    if(f1.length()<2){
                        f1 = "0"+f1
                    }
                    
                    if(f2.length()<2){
                        f2 = "0"+f2
                    }
                    
                    if(f3.length()<2){
                        f3 = "0"+f3
                    }
                    
                    if(f4.length()<2){
                        f4 = "0"+f4
                    }
            
                    Integer a = exp.tms.unshift(count.toString()+"      "+"+ "+f4+":"+f3+":"+f2+"."+f1+"      "+m4+":"+m3+":"+m2+"."+m11)
            }
            
            count=count+1
        }
        
        if(e.img_2=="https://imgur.com/AlVmYeN.png"){//reset
            exp.time="00:00:00.00"
                   num_s = 0
        num_ms = 0
        num_m = 0
        num_h = 0
        count=1
        exp.tms=[]
        exp.ft=[]
        tttt.start()
        
        
        }
    }
    
    void change1(Timer tim){
        exp.img_2="https://imgur.com/AlVmYeN.png" //reset
        exp.img_3="https://imgur.com/GAfCkH5.png" //play
    }
    
        
    void change2(Timer tim){
        exp.img_2= "https://imgur.com/7M3WrUa.png" //flag
            exp.img_3= "https://imgur.com/1lVjUJM.png" //pause
    }
    
        void change3(Timer tim){
        exp.img_1="https://imgur.com/GAfCkH5.png" //play
        exp.img_2= "" //flag
            exp.img_3= "" //pause
    }
    
    void start(Timer timer){
        num_ms = num_ms + 3
        
        if(num_ms>59){
            num_ms=0
            num_s =num_s+1
            if(num_s>59){
                num_s=0
                num_m = num_m+1
                if(num_m>59){
                    num_m=0
                    num_h=num_h+1
                    if(num_h >99){
                        t.stop()
                        exp.time="00:00:00.00"
                    }
                }
            }
        }
        
        String m1 = num_ms.toString()
        String m2 = num_s.toString()
        String m3 = num_m.toString()
        String m4 = num_h.toString()
        
        if(m1.length()<2){
            m1 = "0"+m1
        }
        
        if(m2.length()<2){
            m2 = "0"+m2
        }
        
        if(m3.length()<2){
            m3 = "0"+m3
        }
        
        if(m4.length()<2){
            m4 = "0"+m4
        }
        
        exp.time = m4+":"+m3+":"+m2+"."+m1

    }
    
}