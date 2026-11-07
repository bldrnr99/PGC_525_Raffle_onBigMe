unit uClientStore;

interface

type
  TClient = record
    ID, entrySubFeeID, cardID: Integer;
    fName, lName, alias, Address, Cap, City, SIMIC, IDTeseu, Permit, clType,
      room, iban: string;
    InHouse, Enabled, HasSurCharge, Taxed, SleepsHere: Boolean;
    bdate: TDate;
    lstTaxDate: TDateTime;
    balanceDue: Double;
  end;

TYPE
  TCard = RECORD
    cardID, ClientID: Integer;
    Enabled: Boolean;
    emissionDT: TDateTime;
    Description: STRING;
  END;

TYPE
  TLastTx = RECORD
    lTxID, lTxFeeDesc, lTxCostCenter: STRING;
    lTxBal, lTxVatBal: Double;
    lTxClientID, lTxCardID, lTxFeeID, lTxSubFeeID, lTxVFeeID,
      lTxVSubFeeID: Integer;
    lTxSoldDT, lTxStartDt: TDateTime;
    lTxValid: Boolean;
  END;

TYPE
  TBooking = RECORD
    guestID, bookingID, buildingID, apartmentID, roomID, bedID: Integer;
    singleOccupancy, reemboursment: Boolean;
    checkInDt, checkOutDt, willCheckOutToday, DepositINdt: TDateTime;
    depositAmtPayed, roomRateToPay: Double;
    Address, alias, depositPayMethod, txID: STRING;
  END;

TYPE
  TRental = RECORD
    Description: STRING;
    TotalFeeCHF, TotalShortTerm, TotalSingle, FeeCHF, SupShortTerm,
      SupSingle: Double;
    DaysToPay: Integer;
    PayedUntilDate, ToPayUntilDate: TDate;
    RoomIsSingleOccupancy: Boolean;
  END;

var
  ThisClient: TClient;
  ThisCard: TCard;
  LastTxData: TLastTx;
  ThisBooking: TBooking;
  RentalData: TRental;

implementation

end.
