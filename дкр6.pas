const
  MAX_SIZE = 100;

type
  Node = record
    Data: Integer;
    Next: Integer;
  end;

var
  List: array[1..MAX_SIZE] of Node;
  Head: Integer;
  Free: Integer;

procedure InitializeList;
var
  i: Integer;
begin
  for i := 1 to MAX_SIZE - 1 do
    List[i].Next := i + 1;
  List[MAX_SIZE].Next := 0;
  Head := 0;
  Free := 1;
end;

function IsListEmpty: Boolean;
begin
  Result := Head = 0;
end;

function IsListFull: Boolean;
begin
  Result := Free = 0;
end;

function GetFreeNode: Integer;
var
  NodeIndex: Integer;
begin
  NodeIndex := Free;
  Free := List[Free].Next;
  List[NodeIndex].Next := 0;
  Result := NodeIndex;
end;

procedure ReleaseNode(NodeIndex: Integer);
begin
  List[NodeIndex].Next := Free;
  Free := NodeIndex;
end;

procedure AddToList(Data: Integer);
var
  NodeIndex: Integer;
begin
  if IsListFull then
  begin
    writeln('Список переполнен');
    Exit;
  end;
  NodeIndex := GetFreeNode;
  List[NodeIndex].Data := Data;
  if IsListEmpty then
    Head := NodeIndex
  else
    List[NodeIndex].Next := Head;
  Head := NodeIndex;
end;

procedure RemoveFromList;
var
  NodeIndex: Integer;
begin
  if IsListEmpty then
  begin
    writeln('Список пуст');
    Exit;
  end;
  NodeIndex := Head;
  Head := List[Head].Next;
  ReleaseNode(NodeIndex);
end;

procedure PrintList;
var
  NodeIndex: Integer;
begin
  if IsListEmpty then
  begin
    writeln('Список пуст');
    Exit;
  end;
  NodeIndex := Head;
  while NodeIndex <> 0 do
  begin
    write(List[NodeIndex].Data, ' ');
    NodeIndex := List[NodeIndex].Next;
  end;
  writeln;
end;

var
  Choice, Value: Integer;

begin
  InitializeList;
  repeat
    writeln('1. Добавить элемент');
    writeln('2. Удалить элемент');
    writeln('3. Вывести список');
    writeln('4. Выход');
    write('Выберите пункт: ');
    readln(Choice);
    case Choice of
      1:
        begin
          write('Введите значение для добавления: ');
          readln(Value);
          AddToList(Value);
        end;
      2: RemoveFromList;
      3: PrintList;
      4: break;
    else
      writeln('Некорректно');
    end;
  until False;
end.
