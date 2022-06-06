unit uClasseContrato;

interface

uses
   System.SysUtils, Vcl.StdCtrls, uClasseGrao, uClasseTrade, uClasseSilo, uClasseProdutor;

  type
   TContrato = class
      private
        fId   : Integer;
        fQTDE_GERAL : Double;
        fGrao       : TGrao;
        fTrade      : TTrade;
        fProdutor   : TProdutor;

        Procedure GetIDContrato;
        function ExcluirMovimentacaoAntiga: Boolean;

      public
        Constructor Create;     // declaração do metodo construtor

        property vId         : Integer read fId write fId;
        property vQTDE_GERAL : Double read fQTDE_GERAL write fQTDE_GERAL;
        property vGrao       : TGrao read fGrao write fGrao;
        property vTrade      : TTrade read fTrade write fTrade;
        property vProdutor   : TProdutor read fProdutor write fProdutor;

        Destructor  Destroy; Override; // declaração do metodo destrutor


        function InserirContrato : Boolean;
        function AlterarContrato : Boolean;
        function PesquisarContrato(vValor : string):Boolean;
        function Verificar_Silo_Grao_and_Trade: Integer;
        function Verificar_Armazenamento_Silo(vIgnorarContratoAtual:STRING): Double;
        function Inserir_Movimentacao_Silo: Boolean;
  end;
implementation

uses
   Data.DB, uDM;

{TContrato}

constructor TContrato.Create;
begin
  vGrao     := TGrao.Create;
  vTrade    := TTrade.Create;
  vProdutor := TProdutor.Create;
end;

destructor TContrato.Destroy;
begin
  vGrao.Destroy;
  vTrade.Destroy;
  vProdutor.Destroy;

  inherited;
end;

Procedure TContrato.GetIDContrato;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    'SELECT GEN_ID(gen_contrato_id,1) ID_CONTRATO FROM RDB$DATABASE ';
  DM.qryGlobal.Open;
  Self.vId := DM.qryGlobal.FieldByName('ID_CONTRATO').AsInteger;
  DM.Trans.CommitRetaining;
end;

function TContrato.Verificar_Silo_Grao_and_Trade: Integer;
begin
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    'SELECT count(*) QTDE from SILO s ' +
    'WHERE s.id_grao =:vIDGrao and s.id_trade =:vIDTrade and s.status = ''Ativo'' ';

  DM.qryGlobal.ParamByName('vIDGrao').asInteger  := Self.vGrao.vId;
  DM.qryGlobal.ParamByName('vIDTrade').asInteger := Self.vTrade.vId;
  DM.qryGlobal.Open;

  Result := DM.qryGlobal.FieldByName('QTDE').AsInteger;
end;

function TContrato.Verificar_Armazenamento_Silo(vIgnorarContratoAtual:STRING): Double;
var
  vQtdeDiponivel, vCapacidade, vArmazenado:Double;
begin

  {$REGION 'CONSULTA ARMAZENAMENTO'}
  DM.qryGlobal.Close;
  DM.qryGlobal.SQL.Text :=
    'SELECT sum(sm.qtde_armazenamento) qtdeArmazenada, s.capacidade, s.id ' +
    'FROM SILO s ' +
    'LEFT JOIN SILO_MOVIMENTACAO sm on s.id = sm.id_silo ';

  if vIgnorarContratoAtual = 'True' then begin
    DM.qryGlobal.SQL.Add(' and sm.ID_Contrato <>:vID_Contrato');
    DM.qryGlobal.ParamByName('vID_Contrato').asInteger := Self.vId;
  end;

  DM.qryGlobal.SQL.Add('WHERE s.id_grao =:vIDGrao and s.id_trade =:vIDTrade and s.status = ''Ativo'' ');
  DM.qryGlobal.SQL.Add('GROUP BY s.capacidade, s.id ');

  DM.qryGlobal.ParamByName('vIDGrao').asInteger  := Self.vGrao.vId;
  DM.qryGlobal.ParamByName('vIDTrade').asInteger := Self.vTrade.vId;
  DM.qryGlobal.Open;
  DM.qryGlobal.First;
  {$ENDREGION}

  while not DM.qryGlobal.Eof do begin
    vCapacidade := StrToFloat(FormatFloat('##0.00', DM.qryGlobal.FieldByName('capacidade').AsFloat));
    vArmazenado := StrToFloat(FormatFloat('##0.00', DM.qryGlobal.FieldByName('qtdeArmazenada').AsFloat));

    vQtdeDiponivel := vQtdeDiponivel + (vCapacidade - vArmazenado);
    DM.qryGlobal.Next
  end;

  Result := vQtdeDiponivel;
end;

function TContrato.Inserir_Movimentacao_Silo: Boolean;
var
  vQtdeRestante, vQtdeMaxima, vCapacidade, vArmazenado:Double;
begin
  try
    vQtdeRestante := vQTDE_GERAL;

    {$REGION 'CONSULTA ARMAZENAMENTO'}
    DM.qryGlobal.Close;
    DM.qryGlobal.SQL.Text :=
      'SELECT sum(sm.qtde_armazenamento) qtdeArmazenada, s.capacidade, s.id ID_Silo ' +
      'FROM SILO s ' +
      'LEFT JOIN SILO_MOVIMENTACAO sm  on s.id = sm.id_silo ' +
      'WHERE s.id_grao =:vIDGrao and s.id_trade =:vIDTrade and s.status = ''Ativo'' ' +
      'GROUP BY s.capacidade, s.id ';

    DM.qryGlobal.ParamByName('vIDGrao').asInteger  := Self.vGrao.vId;
    DM.qryGlobal.ParamByName('vIDTrade').asInteger := Self.vTrade.vId;
    DM.qryGlobal.Open;
    DM.qryGlobal.First;
    {$ENDREGION}

    while not DM.qryGlobal.Eof do begin
      if vQtdeRestante > 0 then begin
        vCapacidade := StrToFloat(FormatFloat('##0.00', DM.qryGlobal.FieldByName('capacidade').AsFloat));
        vArmazenado := StrToFloat(FormatFloat('##0.00', DM.qryGlobal.FieldByName('qtdeArmazenada').AsFloat));
        vQtdeMaxima := (vCapacidade - vArmazenado);

        {$REGION 'INSERT ARMAZENAMENTO'}
        DM.qryInsert.Close;
        DM.qryInsert.SQL.Text :=
          'INSERT INTO SILO_MOVIMENTACAO (ID_CONTRATO, ID_SILO, QTDE_ARMAZENAMENTO) ' +
          'VALUES (:vID_CONTRATO, :vID_SILO, :vQTDE_ARMAZENAMENTO)';

        DM.qryInsert.ParamByName('vID_CONTRATO').asInteger := Self.vId;
        DM.qryInsert.ParamByName('vID_SILO').asInteger     := DM.qryGlobal.FieldByName('ID_Silo').asInteger;

        if vQtdeMaxima >= vQtdeRestante then begin
          DM.qryInsert.ParamByName('vQTDE_ARMAZENAMENTO').AsFloat := vQtdeRestante;
          vQtdeRestante :=0;
        end
        else begin
          DM.qryInsert.ParamByName('vQTDE_ARMAZENAMENTO').AsFloat := vQtdeMaxima;
          vQtdeRestante := vQtdeRestante - vQtdeMaxima;
        end;

        DM.qryInsert.ExecSQL;
        {$ENDREGION}

      end;

      DM.qryGlobal.Next
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TContrato.InserirContrato: Boolean;
begin
  try
    GetIDContrato();

    {$REGION 'INSERT CONTRATO'}
    DM.qryGlobal.Close;
    DM.qryGlobal.SQL.Text :=
      'INSERT INTO CONTRATO (ID, ID_PRODUTOR, ID_TRADE, ID_GRAO, QTDE_GERAL) ' +
      'VALUES (:vID, :vID_PRODUTOR, :vID_TRADE, :vID_GRAO, :vQTDE_GERAL)   ';

    DM.qryGlobal.ParamByName('vID').asInteger          := Self.vId;
    DM.qryGlobal.ParamByName('vID_PRODUTOR').asInteger := Self.vProdutor.vId;
    DM.qryGlobal.ParamByName('vID_GRAO').asInteger     := Self.vGrao.vId;
    DM.qryGlobal.ParamByName('vID_TRADE').asInteger    := Self.vTrade.vId;
    DM.qryGlobal.ParamByName('vQTDE_GERAL').asFloat    := Self.vQTDE_GERAL;

    DM.qryGlobal.ExecSQL;
    {$ENDREGION}

    Inserir_Movimentacao_Silo();

    DM.Trans.CommitRetaining;

    Result := True;
  except
    DM.Trans.RollbackRetaining;
    Result := False;
  end;
end;

function TContrato.ExcluirMovimentacaoAntiga: Boolean;
begin
  try
    DM.qryGlobal.Close;
    DM.qryGlobal.SQL.Text :=
      ' DELETE FROM SILO_MOVIMENTACAO WHERE ID_Contrato =:vID_CONTRATO ';
    DM.qryGlobal.ParamByName('vID_CONTRATO').asInteger := Self.vId;
    DM.qryGlobal.ExecSQL;

    Result := True;
  except
    Result := False;
  end;
end;

function TContrato.AlterarContrato: Boolean;
begin
  try
    ExcluirMovimentacaoAntiga();

    DM.qryGlobal.Close;
    DM.qryGlobal.SQL.Text :=
      'UPDATE CONTRATO SET ID_PRODUTOR =:vID_PRODUTOR, ID_TRADE =:vID_TRADE, ' +
      '                    ID_GRAO =:vID_GRAO, QTDE_GERAL =:vQTDE_GERAL ' +
      ' WHERE (ID=:vID)';

    DM.qryGlobal.ParamByName('vQTDE_GERAL').asFloat    := Self.vQTDE_GERAL;
    DM.qryGlobal.ParamByName('vID_GRAO').asInteger     := Self.vGrao.vId;
    DM.qryGlobal.ParamByName('vID_TRADE').asInteger    := Self.vTrade.vId;
    DM.qryGlobal.ParamByName('vID_PRODUTOR').asInteger := Self.vProdutor.vId;
    DM.qryGlobal.ParamByName('vID').asInteger          := Self.vId;

    DM.qryGlobal.ExecSQL;
    Inserir_Movimentacao_Silo();

    DM.Trans.CommitRetaining;
    Result := True;
  except
    DM.Trans.RollbackRetaining;
    Result := False;
  end;
end;

function TContrato.PesquisarContrato(vValor : string):Boolean;
begin
  DM.qryContrato.close;
  DM.qryContrato.SQL.Text :=
    'SELECT c.id, c.qtde_geral,                     ' +
    '       c.id_produtor, p.nome PRODUTOR, p.CNPJ, ' +
    '       c.id_trade, t.descricao TRADE,          ' +
    '       c.id_grao, g.descricao GRAO             ' +
    'FROM CONTRATO c                                ' +
    'INNER JOIN GRAO g on g.id = c.id_grao          ' +
    'INNER JOIN TRADE t on t.id = c.id_trade        ' +
    'INNER JOIN PRODUTOR p on p.id = c.id_produtor  ' +
    'WHERE c.ID=:vID ';

  DM.qryContrato.ParamByName('vID').AsString := vValor;
  DM.qryContrato.Open;
  DM.qryContrato.First;

  Self.vId         := DM.qryContrato.FieldByName('ID').AsInteger;
  Self.vQTDE_GERAL := DM.qryContrato.FieldByName('QTDE_GERAL').AsInteger;

  self.vGrao.PesquisarGrao('ID', DM.qryContrato.FieldByName('ID_GRAO').AsString);
  self.vTrade.PesquisarTrade('ID', DM.qryContrato.FieldByName('ID_TRADE').AsString);
  self.vProdutor.PesquisarProdutor('ID', DM.qryContrato.FieldByName('ID_PRODUTOR').AsString);

  Result := (not DM.qryContrato.eof);
end;

end.
