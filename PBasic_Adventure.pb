EnableExplicit

; Define our cardinal directions as degrees
Enumeration
  #North = 360
  #South = 180
  #East = 90
  #West = 270
EndEnumeration

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
    
    ; AskYesNo() will come back as #True or #False
    If (AskYesNo())
      PrintN("You decided to read the note. Let's see...")
      ; to-do: note
      PauseGame()
    Else
      PrintN("You decide not to read the note.")
      PrintN("You're capable of going north, south, east, or west from here.")
      PrintN(Str(AskDirection(1, 1, 1, 1)))
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
  
  Select Trim(LCase(Input()))
    Case "yes", "y"
      ProcedureReturn #True
    Case "no", "n"
      ProcedureReturn #False
    Default:
      PrintN("I didn't understand that.")
      AskYesNo()
  EndSelect
EndProcedure


Procedure.l AskDirection(north, south, east, west)
  PrintN("")
  Print("Which way would you like to go? Options: ")
  
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
  
  ; User types a direction. If valid, return it to GameLoop(), otherwise ask user again
  Select LCase(Trim(Input())) 
    Case "north", "n"
      ProcedureReturn #North
    Case "south", "s"
      ProcedureReturn #South
    Case "east", "e"
      ProcedureReturn #East
    Case "west", "w"
      ProcedureReturn #West
    Default
      PrintN("I didn't understand that.")
      AskDirection(north, south, east, west)
  EndSelect
EndProcedure


; To be used for freeform / custom questions
Procedure.s AskAnything(user_question.s)
  PrintN("")
  PrintN(user_question)
  Print(#INDENT_INPUT)
  ProcedureReturn Trim(LCase(Input()))
EndProcedure


; Call the main loop, defined 
GameLoop()
; IDE Options = PureBasic 6.00 LTS (Linux - x64)
; ExecutableFormat = Console
; CursorPosition = 70
; FirstLine = 117
; Folding = -
; EnableXP
; DPIAware
; CompileSourceDirectory