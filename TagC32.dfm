object TagReader: TTagReader
  OnDestroy = DataModuleDestroy
  Height = 232
  Width = 411
  object ApdComPort1: TApdComPort
    ComNumber = 3
    Baud = 9600
    PromptForPort = False
    AutoOpen = False
    RTS = False
    TraceName = 'APRO.TRC'
    LogName = 'APRO.LOG'
    OnTriggerAvail = ApdComPort1TriggerAvail
    Left = 74
    Top = 50
  end
  object ApdDataPacket1: TApdDataPacket
    Enabled = True
    EndCond = [ecString]
    StartString = #10
    EndString = #13#10
    ComPort = ApdComPort1
    PacketSize = 0
    IncludeStrings = False
    OnPacket = ApdDataPacket1Packet
    OnTimeout = ApdDataPacket1Timeout
    Left = 173
    Top = 64
  end
end
