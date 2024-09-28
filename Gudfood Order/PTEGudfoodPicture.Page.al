page 50001 "PTE Gudfood Picture"
{
    ApplicationArea = All;
    Caption = 'PTE Gudfood Picture';
    PageType = CardPart;
    SourceTable = "PTE Gudfood Item";

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPircture)
            {
                Caption = 'Import Picture';
                Image = Import;
                ToolTip = 'Executes the Import Picture action.';

                trigger OnAction()
                begin
                    ImportFromDevice();
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    StringConversionManager: Codeunit StringConversionManagement;
                    ToFile: Text;
                    ConvertedCodeType: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    Rec.TestField(Description);
                    ConvertedCodeType := Format(Rec."No.");
                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ConvertedCodeType := StringConversionManager.RemoveNonAlphaNumericCharacters(ConvertedCodeType);
                    ExportPath := TemporaryPath + ConvertedCodeType + Format(Rec.Picture.MediaId);
                    Rec.Picture.ExportFile(ExportPath + '.' + DummyPictureEntity.GetDefaultExtension());

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
        }
    }

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        InStr: InStream;
    begin
        if Rec.Picture.Count > 0 then
            if not Confirm('Do you want overide?') then
                Error('');

        Clear(Rec.Picture);
        UploadIntoStream('Import Picture', '', '', FileName, InStr);
        Rec.Picture.ImportStream(InStr, '');
        Rec.Modify(true);

    end;
}
