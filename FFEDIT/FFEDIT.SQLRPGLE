
       Ctl-Opt DftActGrp(*No) ActGrp(*NEW);

       Dcl-Pi FFEDIT;
         pLib Char(10);
         pSPF Char(10);
         pMbr Char(10);
       END-PI;

      *  __________________________________________
      *  External definitions.

       Dcl-PR Run ExtPgm('QCMDEXC');
         Command Char(200)    Const;
         Length  Packed(15:5) Const;
       END-PR;

       Dcl-Pr CommandEntry ExtPgm('QUSCMDLN');
       END-PR;

      *  __________________________________________
      *  These variables are for the display file.

       dcl-f MAINSCRN workstn;

       Dcl-S gLine_Num  Like(LIN_NO) Inz(0);
       Dcl-S gPosi_Num  Like(POS_NO) Inz(0);

      *  __________________________________________

       Dcl-S gAlias Char(10);            //Used for SQL
       Dcl-S gUser  Char(10) Inz(*User); //Constant

       Dcl-S gLib   Char(10); //Library
       Dcl-S gSPF   Char(10); //Source physical file
       Dcl-S gMbr   Char(10); //Member

      * SOURCE holds the source member in.
      * SourceMax holds the max lines of the current member.
       Dcl-S  SourceMax Int(10);
       Dcl-Ds SOURCE    Qualified Dim(32000);
         Line Char(100);
       END-DS;

      * gCopy* is used to keep track of line numbers.
      * gClip* Contains the clipboard data.
       Dcl-S gCopyStart Int(10);
       Dcl-S gCopyEnd   Int(10);
       Dcl-S gClipboard Like(Source.Line) Dim(100);
       Dcl-S gClipLen   Int(10);

       *InLR = *On;

      *  __________________________________________

       If (%Parms <> 3);
         //showMessage('Too many or not enough parameters passed.');
         //Return;
         Exfmt SLOAD;

         gLib = LLIB;
         gSPF = LSPF;
         gMbr = LMBR;

       Else;

         gLib = pLib;
         gSPF = pSPF;
         gMbr = pMbr;

       ENDIF;

       If (Mbr_Exists(gLib:gSPF:gMbr));
         gAlias = 'FF' + %Trim(%Subst(gUser:1:3)) + %Trim(%Subst(gMbr:1:5));
         If (LoadMbr(gLib:gSPF:gMbr) = *Off);
           Return;
         ENDIF;
       Else;
         showMessage('Provided member does not exist.');
         Return;
       ENDIF;

       CallP Mainline();

       Return;

      *  __________________________________________
      *  Mainline is the procedure with the actual
      *  editor screen. Should only be called once at the
      *  start of the program.

       Dcl-Proc Mainline;
         Dcl-S lStartCur Int(10) Inz(1);
         Dcl-S lExit     Ind     Inz(*Off);

         SLIBNAME = gLib;
         SMBRNAME = gMbr;

         Dow (lExit = *Off);

           If (gLine_Num <> 0);
             LIN_NO = gLine_Num;
           ENDIF;
           If (gPosi_Num <> 0);
             POS_NO = gPosi_Num;
           ENDIF;

           NUM1  = %Char(lStartCur + 0);
           NUM2  = %Char(lStartCur + 1);
           NUM3  = %Char(lStartCur + 2);
           NUM4  = %Char(lStartCur + 3);
           NUM5  = %Char(lStartCur + 4);
           NUM6  = %Char(lStartCur + 5);
           NUM7  = %Char(lStartCur + 6);
           NUM8  = %Char(lStartCur + 7);
           NUM9  = %Char(lStartCur + 8);
           NUM10 = %Char(lStartCur + 9);
           NUM11 = %Char(lStartCur + 10);
           NUM12 = %Char(lStartCur + 11);
           NUM13 = %Char(lStartCur + 12);
           NUM14 = %Char(lStartCur + 13);
           NUM15 = %Char(lStartCur + 14);
           NUM16 = %Char(lStartCur + 15);
           NUM17 = %Char(lStartCur + 16);
           NUM18 = %Char(lStartCur + 17);
           NUM19 = %Char(lStartCur + 18);
           NUM20 = %Char(lStartCur + 19);
           NUM21 = %Char(lStartCur + 20);
           NUM22 = %Char(lStartCur + 21);

           LINE1  = Source(lStartCur + 0);
           LINE2  = Source(lStartCur + 1);
           LINE3  = Source(lStartCur + 2);
           LINE4  = Source(lStartCur + 3);
           LINE5  = Source(lStartCur + 4);
           LINE6  = Source(lStartCur + 5);
           LINE7  = Source(lStartCur + 6);
           LINE8  = Source(lStartCur + 7);
           LINE9  = Source(lStartCur + 8);
           LINE10 = Source(lStartCur + 9);
           LINE11 = Source(lStartCur + 10);
           LINE12 = Source(lStartCur + 11);
           LINE13 = Source(lStartCur + 12);
           LINE14 = Source(lStartCur + 13);
           LINE15 = Source(lStartCur + 14);
           LINE16 = Source(lStartCur + 15);
           LINE17 = Source(lStartCur + 16);
           LINE18 = Source(lStartCur + 17);
           LINE19 = Source(lStartCur + 18);
           LINE20 = Source(lStartCur + 19);
           LINE21 = Source(lStartCur + 20);
           LINE22 = Source(lStartCur + 21);

           Exfmt SEDITOR;

           If (NOT *In05);
             Source(lStartCur + 0)  = LINE1;
             Source(lStartCur + 1)  = LINE2;
             Source(lStartCur + 2)  = LINE3;
             Source(lStartCur + 3)  = LINE4;
             Source(lStartCur + 4)  = LINE5;
             Source(lStartCur + 5)  = LINE6;
             Source(lStartCur + 6)  = LINE7;
             Source(lStartCur + 7)  = LINE8;
             Source(lStartCur + 8)  = LINE9;
             Source(lStartCur + 9)  = LINE10;
             Source(lStartCur + 10) = LINE11;
             Source(lStartCur + 11) = LINE12;
             Source(lStartCur + 12) = LINE13;
             Source(lStartCur + 13) = LINE14;
             Source(lStartCur + 14) = LINE15;
             Source(lStartCur + 15) = LINE16;
             Source(lStartCur + 16) = LINE17;
             Source(lStartCur + 17) = LINE18;
             Source(lStartCur + 18) = LINE19;
             Source(lStartCur + 19) = LINE20;
             Source(lStartCur + 20) = LINE21;
             Source(lStartCur + 21) = LINE22;
           Endif;

           Select;
             When (*In03); //Exit
               lExit = DspExitWindow();

             When (*In06); //Find
               Find();

             When (*In21);
               CommandEntry();

             When (*In44);
               If (lStartCur - 5 >= 1);
                 lStartCur -= 5;
               Else;
                 lStartCur = 1;
               Endif;
             When (*In66);
               If ((lStartCur + 5) < (SourceMax - 21));
                 lStartCur += 5;
               Else;
                 lStartCur = (SourceMax - 21);
               Endif;

             When (*In17); //Shift f5
               lStartCur = (SourceMax - 21);
             When (*In18);
               lStartCur = 1;

             Other;
               CheckParams(lStartCur);

           ENDSL;

           If (lStartCur < 1);
             lStartCur = 1;
           ENDIF;

           If (lExit = *On);
             //call save procedure?
           ENDIF;
         ENDDO;

       END-PROC;

      *  __________________________________________
      *  Displays an option window before exiting the
      *  program. This allows you to save and exit, exit or cancel.

       Dcl-Proc DspExitWindow;
         Dcl-Pi DspExitWindow Ind;
         END-PI;

         Dow (1 = 1);
           EXITVAL = 'C';
           Exfmt SEXIT;

           Select;

             When (*In12);
               Return *Off;

             Other;
               Select;
                 When (EXITVAL = 'C'); //Cancel
                   Return *Off;
                 When (EXITVAL = 'N'); //Don't save
                   ExitPgm();
                   Return *On;
                 When (EXITVAL = 'Y'); //Save
                   SaveMbr();
                   ExitPgm();
                   Return *On;
               ENDSL;

           ENDSL;

         ENDDO;

       End-Proc;

      *  __________________________________________
      *  Search for a string, it will then display
      *  the lines numbers relevant to the search.
      *  IS DUE A REWORK

       Dcl-Proc Find;
         Dcl-S lExit  Ind          Inz(*Off);
         Dcl-S lVal   Varchar(80);
         Dcl-S lOccur Varchar(100);
         Dcl-S lCur   Int(10);

         Dow (lExit = *Off);
           Exfmt SFIND;

           Select;

             When (*In12);
               lExit = *On;

             Other;
               lOccur = '';
               lVal   = %Trim(FINDVAL);

               If (lVal <> *Blank);

                 For lCur = 1 to SourceMax;
                   If (%Scan(lVal:Source(lCur).Line) > 0);
                     lOccur += %Char(lCur) + ', ';
                   ENDIF;
                 ENDFOR;

                 If (lOccur = *Blank);
                   showMessage('No result found for "' + lVal + '"');
                 Else;
                   showMessage('Scan for "' + lVal + '" found at lines: '
                            + lOccur);
                 ENDIF;

               Endif;

           ENDSL;
         ENDDO;

       End-Proc;

      *  __________________________________________
      *  Delete the alias and unlock the memeber.

       Dcl-Proc ExitPgm;
         Dcl-S lQuery Varchar(500);
         Dcl-S lCmd   Char(200);

         lQuery = 'DROP ALIAS QTEMP/' + %Trim(gAlias);
         SqlExecute(lQuery);

         lCmd = 'DLCOBJ OBJ(('
              + %Trim(gLib) + '/' + %Trim(gSPF)
              + ' *FILE *EXCLRD '
              + %Trim(gMbr)
              + '))';
         Run(lCmd:%Len(lCmd));
       End-Proc;

      *  __________________________________________
      *  Create the alias, load the member and then lock it.

       Dcl-Proc LoadMbr;
5315     Dcl-PI LoadMbr Ind;
5415       pMBR_Lib  Char(10) Const;
5515       pMBR_SPF  Char(10) Const; //Physical file
5615       pMBR_Name Char(10) Const;
5715     END-PI;
         Dcl-S lQuery Varchar(500);
         Dcl-S lCmd   Char(200);

         lQuery = 'CREATE ALIAS QTEMP/' + %Trim(gAlias) + ' FOR '
                + %Trim(pMBR_Lib) + '/'
                + %Trim(pMBR_SPF)
                + '(' + %Trim(pMBR_Name) + ')';

         If (SqlExecute(lQuery) = '42');

           lQuery = 'DROP ALIAS QTEMP/' + %Trim(gAlias);
           SqlExecute(lQuery);

           showMessage('Previous SQL error has caused a fault. '
                     + 'Try re-opening the member. This was caused because a '
                     + 'previous program trying to use '
                     + %Trim(pMBR_Lib) + '/'
                     + %Trim(pMBR_SPF)
                     + '(' + %Trim(pMBR_Name) + '). '
                     + 'The alias how now been dropped.');

           Return *Off;

         ENDIF;

         lQuery = 'SELECT SRCDTA '
                + 'FROM QTEMP/' + %Trim(gAlias);

         EXEC SQL
           PREPARE SMbr FROM :lQuery;
         EXEC SQL
           DECLARE SearchMbr CURSOR FOR SMbr;

         EXEC SQL OPEN SearchMbr;
         EXEC SQL
           FETCH NEXT FROM SearchMbr
           FOR 32000 ROWS
           INTO :SOURCE;

         SourceMax = SQLER3;
         If (SourceMax < 22);
           SourceMax = 22;
         ENDIF;

         EXEC SQL CLOSE SearchMbr;

         lCmd = 'ALCOBJ OBJ(('
              + %Trim(pMBR_Lib) + '/' + %Trim(pMBR_SPF)
              + ' *FILE *EXCLRD '
              + %Trim(pMBR_Name)
              + '))';
         Run(lCmd:%Len(lCmd));

         Return *On;
       END-PROC;

      *  __________________________________________

       Dcl-Proc SaveMbr;
         Dcl-s lCount Int(10);
         Dcl-S lQuery Varchar(500);

         lQuery = 'DELETE FROM QTEMP/' + %Trim(gAlias);
         SqlExecute(lQuery);

         For lCount = 1 to SourceMax;
           lQuery = 'INSERT INTO QTEMP/' + %Trim(gAlias)
                  + ' VALUES ('
                  +   %Char(lCount) + ', '
                  +   '0, '''
                  +   %ScanRpl('''':'''''':Source(lCount).Line)
                  + ''')';

      * I'm not a big fan of the ScanRpl here. It just duplicates characters
      * so the SQL doesn't error when there is an apostrophe on a line.

           SqlExecute(lQuery);
         ENDFOR;

       End-Proc;

      *  __________________________________________
      *  On the editor, each line allows you to enter a
      *  character command. This procedure defines them.
      *   - I = Move this line down by 1.
      *   - X = Clear line
      *   - C = Comment line out
      *   - D = Delete line
      *   - S = Start copy
      *   - E = End copy
      *   - P = Paste (max of 100 lines)
      *

       Dcl-Proc CheckParams;
         Dcl-Pi CheckParams;
           pStartCur Int(10) Const;
         END-PI;
         Dcl-S lField Char(1) Dim(22);
         Dcl-S lCount Int(3);

         gLine_Num = 5;
         gPosi_Num = 14;

         lField(1)  = %Subst(NUM1:1:1);
         lField(2)  = %Subst(NUM2:1:1);
         lField(3)  = %Subst(NUM3:1:1);
         lField(4)  = %Subst(NUM4:1:1);
         lField(5)  = %Subst(NUM5:1:1);
         lField(6)  = %Subst(NUM6:1:1);
         lField(7)  = %Subst(NUM7:1:1);
         lField(8)  = %Subst(NUM8:1:1);
         lField(9)  = %Subst(NUM9:1:1);
         lField(10) = %Subst(NUM10:1:1);
         lField(11) = %Subst(NUM11:1:1);
         lField(12) = %Subst(NUM12:1:1);
         lField(13) = %Subst(NUM13:1:1);
         lField(14) = %Subst(NUM14:1:1);
         lField(15) = %Subst(NUM15:1:1);
         lField(16) = %Subst(NUM16:1:1);
         lField(17) = %Subst(NUM17:1:1);
         lField(18) = %Subst(NUM18:1:1);
         lField(19) = %Subst(NUM19:1:1);
         lField(20) = %Subst(NUM20:1:1);
         lField(21) = %Subst(NUM21:1:1);
         lField(22) = %Subst(NUM22:1:1);

         For lCount = 1 to %Elem(lField);
           Select;

             When (lField(lCount) = 'I');
               If NOT (InsertLine(pStartCur + (lCount - 1)));
                 showMessage('Unable to insert new line at: '
                           + %Char(pStartCur + (lCount - 1)));
                 Return;
               Else;
                 gLine_Num = 4 + lCount;
               ENDIF;

             When (lField(lCount) = 'X');
               If NOT (ClearLine(pStartCur + (lCount - 1)));
                 Return;
               Else;
                 gLine_Num = 4 + lCount;
               ENDIF;


             When (lField(lCount) = 'C');
               If NOT (CommentLine(pStartCur + (lCount - 1)));
                 Return;
               Else;
                 gLine_Num = 4 + lCount;
               ENDIF;


             When (lField(lCount) = 'D');
               If NOT (DeleteLine(pStartCur + (lCount - 1)));
                 showMessage('Unable to delete line at: '
                           + %Char(pStartCur + (lCount - 1)));
                 Return;
               Else;
                 gPosi_Num = 5;
                 gLine_Num = 4 + lCount;
                 Return;
               ENDIF;

             When (lField(lCount) = 'S'); //Set copy start
               gCopyStart = pStartCur + (lCount - 1);
               gPosi_Num  = 5;
               gLine_Num  = 4 + lCount;
               Return;
             When (lField(lCount) = 'E'); //Set copy start
               gCopyEnd  = pStartCur + (lCount - 1);
               gPosi_Num = 5;
               gLine_Num = 4 + lCount;
               DoCopy();
               Return;
             When (lField(lCount) = 'P');
               If NOT (DoPaste(pStartCur + (lCount - 1)));
                 showMessage('Unable to paste from line: '
                           + %Char(pStartCur + (lCount - 1)));
                 Return;
               Else;
                 gLine_Num = 4 + lCount;
                 Return;
               ENDIF;

           ENDSL;

           If (SourceMax < 21);
             SourceMax = 22;
           ENDIF;
         ENDFOR;

       End-Proc;

      *  __________________________________________
      *  Checks if a member exists - not the best code.

5215   Dcl-Proc MBR_Exists;
5315     Dcl-PI MBR_Exists Ind;
5415       pMBR_Lib  Char(10) Const;
5515       pMBR_SPF  Char(10) Const; //Physical file
5615       pMBR_Name Char(10) Const;
5715     END-PI;
6015     Dcl-S Command Char(200);
6115
6215     Command = 'CHKOBJ OBJ(' + %Trim(pMBR_Lib) +
6315     '/' + %Trim(pMBR_SPF) + ') OBJTYPE(*FILE) MBR(' + %Trim(pMBR_Name)
             + ')';
6415
6515     Monitor;
6615       //If this errors, then the member doesn't exist.
6715       Run(Command:%Len(Command));
6815       Return *On;
6915
7015     On-Error *ALL;
7115       Return *Off;
7215
7315     ENDMON;
7415
7515     Return *Off;
7615   END-PROC;

      *  __________________________________________
      *  Inserts a line at a specific number.

       Dcl-Proc InsertLine;
         Dcl-Pi InsertLine Ind;
           pLine Int(10) Const;
         END-PI;
         Dcl-S lCur Int(10);
         Dcl-S lEnd Int(10);

         lEnd = SourceMax + 1;

         If (lEnd >= 32000);
           Return *Off;
         ENDIF;

         For lCur = (lEnd) downto pLine;

           SOURCE(lCur + 1).Line = SOURCE(lCur).Line;

         ENDFOR;
         SOURCE(pLine).Line = *Blank;

         SourceMax += 1;

         Return *On;
       END-PROC;

      *  __________________________________________
      *  Clear a certain line.

       Dcl-Proc ClearLine;
         Dcl-Pi ClearLine Ind;
           pLine Int(10) Const;
         END-PI;

         SOURCE(pLine).Line = *Blank;

         Return *On;
       END-PROC;

      *  __________________________________________
      *  Comment out a certain line

       Dcl-Proc CommentLine;
         Dcl-Pi CommentLine Ind;
           pLine Int(10) Const;
         END-PI;

         %Subst(SOURCE(pLine).Line:7:1) = '*';

         Return *On;
       End-Proc;

      *  __________________________________________
      *  Delete a certain line

       Dcl-Proc DeleteLine;
         Dcl-Pi DeleteLine Ind;
           pLine Int(10) Const;
         END-PI;
         Dcl-S lCur Int(10);
         Dcl-S lEnd Int(10);

         lEnd = SourceMax;
         If (lEnd >= 32000);
           Return *Off;
         ENDIF;

         For lCur = pLine to lEnd;
           Source(lCur).Line = Source(lCur + 1).Line;
         ENDFOR;

         SourceMax -= 1;

         Return *On;
       End-Proc;

      *  __________________________________________
      *  Copy lines chosen by using S and E.

       Dcl-Proc DoCopy;
         Dcl-S lCount   Int(10);
         Dcl-S lEle     Int(10);
         Dcl-S lClipLen Int(10);

         If (gCopyEnd < gCopyStart);
           showMessage('Cannot copy nothing.');
         ENDIF;

         lClipLen = (gCopyEnd - gCopyStart) + 1;
         If (lClipLen > %Elem(gClipboard));
           showMessage('More than maximum lines copied.');
         ENDIF;

         lEle = 1;
         For lCount = gCopyStart to gCopyEnd;
           gClipboard(lEle) = Source(lCount).Line;
           lEle += 1;
         ENDFOR;

         gClipLen = lClipLen;

       End-Proc;

      *  __________________________________________
      *  Paste the chosen copy lines.

       Dcl-Proc DoPaste;
         Dcl-Pi DoPaste Ind;
           pLine Int(10) Const;
         END-PI;
         Dcl-S lCount Int(10);

         For lCount = 1 to gClipLen;
           InsertLine(pLine + (lCount - 1));
           Source(pLine + (lCount - 1)).Line = gClipboard(lCount);
         ENDFOR;

         Return *on;
       End-Proc;

      *  __________________________________________
      *  Run an SQL statement.

       Dcl-Proc SqlExecute;
         Dcl-PI SqlExecute Char(2);
           SQLQUERY Varchar(500);
         END-PI;

         Exec SQL Execute Immediate :SQLQUERY;

         If (%Subst(SQLSTATE:1:2) <> '00');
           showMessage('SQL error: ' + SQLSTATE
                     + ' - "' + SQLQUERY + '"');
         Endif;

         Return %Subst(SQLSTATE:1:2);
       END-PROC;

      *  __________________________________________
      *  Display a message.

       Dcl-Proc showMessage;
         Dcl-Pi showMessage;
           Text        Varchar(8192) Const;
         END-PI;

         Dcl-DS ErrCode;
           BytesIn  Int(10) Inz(0);
           BytesOut Int(10) Inz(0);
         END-DS;

         Dcl-PR QUILNGTX ExtPgm('QUILNGTX');
           MsgText     Char(8192)    Const;
           MsgLength   Int(10)       Const;
           MessageId   Char(7)       Const;
           MessageFile Char(21)      Const;
           dsErrCode   Like(ErrCode);
         END-PR;

         QUILNGTX(Text:%Len(Text):
            '':'':
            ErrCode);

         Return;
       END-PROC; 
