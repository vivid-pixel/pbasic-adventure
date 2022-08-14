EnableExplicit

; Define our cardinal directions as degrees
Enumeration
  #North = 360
  #South = 180
  #East = 90
  #West = 270
EndEnumeration

; User's unmodified response or command will end up here, prior to us evaluating it
Define.s user_input_raw = #Empty$

; User's response processed into numerical form (for AskYesNo() or AskDirection())
Define.l user_choice = 0;

; Some output of the program will require consistent indentation. Ex: Space(#INDENT_LENGTH)
#INDENT_LENGTH = 5

; The characters a user will always see when program is requesting their input
#INDENT_INPUT = ">> "

Declare PauseGame()
Declare.l AskYesNo()
Declare.s AskAnything(user_question.s)
Declare.l AskDirection(north, south, east, west)

Procedure GameLoop()
  If OpenConsole()
    EnableGraphicalConsole(#True)
    Define.s welcome_message = "Welcome to my PBasic Adventure (Terminal Edition)"
    Define.s dividing_line = LSet(#Empty$, Len(welcome_message), "#")
    
    PrintN(Space(#INDENT_LENGTH) + dividing_line)
    PrintN(Space(#INDENT_LENGTH) + welcome_message)
    PrintN(Space(#INDENT_LENGTH) + dividing_line)
    
    PrintN(Space(#INDENT_LENGTH) + "Nice to see you, " + UserName() + ".")
    PauseGame()
    
    PrintN("You're walking in the forest, on a pleasant sunny day. You come across a fallen note " +
           "with cursive writing. Who writes in cursive anymore?")
    PauseGame()
    
    PrintN("Anyway, maybe we should read the note. Could be the coordinates to buried treasure, " +
           "or perhaps something else equally likely.")
    
    user_choice = AskYesNo()
    If (user_choice)
      If (AskAnything("Are you aware that you selected Yes?") = "test")
        Debug("User responded with 'test'")
      EndIf
      PauseGame()
    ElseIf (Not user_choice)
      user_choice = AskDirection(1, 1, 1, 1)
      PrintN(Str(user_choice))
      PauseGame()
    EndIf
    
    CloseConsole()
  EndIf
EndProcedure


Procedure PauseGame()
  PrintN("")
  PrintN(Space(#INDENT_LENGTH) + "[Press Enter/Return when ready.]")
  Input()
EndProcedure


Procedure.l AskYesNo()
  PrintN("")
  PrintN("Type 'yes' or 'no' to make a decision, when ready.")
  Print(#INDENT_INPUT)
  
  ; use user_input_raw variable outside its original scope
  Shared user_input_raw
  user_input_raw = LCase(Trim(Input()))
  
  If user_input_raw = "yes" Or user_input_raw = "y"
    ProcedureReturn #True
  ElseIf user_input_raw = "no" Or user_input_raw = "n"
    ProcedureReturn #False
  Else
    AskYesNo()
  EndIf
EndProcedure


Procedure.l AskDirection(north, south, east, west)
  PrintN("")
  Print("Which way would you like to go? Options: ")
  
  ; Use user_input_raw defined in a different scope, without making it global
  Shared user_input_raw
  
  ; Create a list of the allowed directions passed to the procedure as params
  NewList Directions.s()
  
  ; Only display valid directions of travel as options (specified when calling the procedure)
  If north
    AddElement(Directions())
    Directions() = "north"
  EndIf
  If south
    AddElement(Directions())
    Directions() = "south"
  EndIf
  If east
    AddElement(Directions())
    Directions() = "east"
  EndIf
  If west
    AddElement(Directions())
    Directions() = "west"
  EndIf
  
  ; The valid direction(s) of travel are ready for output
  ForEach Directions()
    Print(Directions())
    Print(" ")
  Next
  
  PrintN("")
  Print(#INDENT_INPUT)
  user_input_raw = LCase(Trim(Input()))
  
  If (user_input_raw = "north" Or user_input_raw = "n")
    ProcedureReturn #North
  ElseIf (user_input_raw = "south" Or user_input_raw = "s")
    ProcedureReturn #South
  ElseIf (user_input_raw = "east" Or user_input_raw = "e")
    ProcedureReturn #East
  ElseIf (user_input_raw = "west" Or user_input_raw = "w")
    ProcedureReturn #West
  Else
    PrintN("Bad or invalid response :(")
    AskDirection(north, south, east, west)
  EndIf
EndProcedure


; used for freeform / custom questions
Procedure.s AskAnything(user_question.s)
  PrintN("")
  PrintN(user_question)
  Print(#INDENT_INPUT)
  Define.s user_reply = Input()
  ProcedureReturn user_reply
EndProcedure

; IDE Options = PureBasic 6.00 LTS (Linux - x64)
; ExecutableFormat = Console
; Folding = -
; EnableXP
; DPIAware
; CompileSourceDirectory