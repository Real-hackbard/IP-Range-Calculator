# IP-Range-Calculator:

```ruby
Compiler    : Delphi10 Seattle, 10.1 Berlin, 10.2 Tokyo, 10.3 Rio, 10.4 Sydney, 11 Alexandria, 12 Athens
Components  : None
Discription : Calculate IP Ranges by Click
Last Update : 08/2025
License     : Freeware
```


The IP Range refers to the Range of IP addresses used by a particular Network or organization. It is a group of IP addresses that share a common prefix address and are defined by the size of the netmask.

This program shows how to calculate such Ranges at the click of a button. It's important to note that the starting IP address cannot be greater than the ending IP address. This applies to both the individual range and the entire IP address.


![Generate IP Range](https://github.com/user-attachments/assets/e1eb89ab-bd83-45c4-be37-d496304e8044)



With a standard subnet mask, additional IP addresses must be assigned within the range up to 192.168.10.254. Therefore, the larger the IP range, the more devices can be used within a network.

The aforementioned suffix after the IP address indicates how many 1s follow one another in the subnet mask in bit notation. Therefore, 24 means 255.255.255.0 for the network ID.

The most common notation for IPv4 addresses in use today consists of four numbers, which can take values from 0 to 255 and are separated by a period, for example, 192.0.2.42 . Technically, the address is a 32-digit (IPv4) or 128-digit (IPv6) binary number.

### Example

```ruby
Wrong entry!
Start - 192.168.0.255
End   - 192.168.0.0

Correct entry!
Start - 192.168.0.0
End   - 192.168.0.255
```

### Who owns IP addresses? 

The Internet Corporation for Assigned Names and Numbers (ICANN) manages and distributes IP addresses. This organization distributes IP addresses to various companies and organizations, which in turn assign them to their customers. However, they retain ownership.

A /16 means that there are 65,536 possible addresses on each network; a /24 means that there are 256 addresses on each network; and a /28 means that there are 16 addresses on each network.

```ruby
# The address ranges usable by private networks are: 
• Class A: 10.0.0.0 to 10.255.255.255. 
• Class B: 172.16.0.0 to 172.31.255.255. 
• Class C: 192.168.0.0 to 192.168.255.255.
```

# More options

```
• Geolocation 
• Ping 
• Tracert 
• Network IP 
• External IP 
• Host from IP
```

To use these options, no additional code is actually required if you work directly with the Windows console.

Cmd.exe (officially known as the Windows Command Prompt) is the operating system shell of OS/2, the Windows NT line, and ReactOS. The shell can process DOS command-line commands and execute batch files.

To connect to the console from this program, you only need this section.

```Delphi
procedure TForm1.CaptureConsoleOutput(const ACommand, AParameters: String; AMemo: TMemo);
 const
   CReadBuffer = 2400;
 var
   saSecurity: TSecurityAttributes;
   hRead: THandle;
   hWrite: THandle;
   suiStartup: TStartupInfo;
   piProcess: TProcessInformation;
   pBuffer: array[0..CReadBuffer] of AnsiChar;
   dRead: DWord;
   dRunning: DWord;
 begin
   saSecurity.nLength := SizeOf(TSecurityAttributes);
   saSecurity.bInheritHandle := True;
   saSecurity.lpSecurityDescriptor := nil;

   if CreatePipe(hRead, hWrite, @saSecurity, 0) then
   begin
     FillChar(suiStartup, SizeOf(TStartupInfo), #0);
     suiStartup.cb := SizeOf(TStartupInfo);
     suiStartup.hStdInput := hRead;
     suiStartup.hStdOutput := hWrite;
     suiStartup.hStdError := hWrite;
     suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
     suiStartup.wShowWindow := SW_HIDE;

     if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity,
       @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess)
       then
     begin
       repeat
         dRunning := WaitForSingleObject(piProcess.hProcess, 100);
         Application.ProcessMessages();
         repeat
           dRead := 0;
           ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
           pBuffer[dRead] := #0;
           OemToAnsi(pBuffer, pBuffer);
           AMemo.Lines.Add(String(pBuffer));
         until
         (dRead < CReadBuffer);
       until
       (dRunning <> WAIT_TIMEOUT);
       CloseHandle(piProcess.hProcess);
       CloseHandle(piProcess.hThread);
     end;

     CloseHandle(hRead);
     CloseHandle(hWrite);
   end;
end;
```

If this is implemented successfully, 99% of all Windows console functions will be available to your program as soon as the application is run.

CMD Commands : https://learn.microsoft.com/de-de/windows-server/administration/windows-commands/cmd
