#include <iostream>
#include <windows.h>
#include <shobjidl.h>
#include <QtDebug>

#include "WindowsFileSelectionHandler.h"

WindowsFileSelectionHandler::WindowsFileSelectionHandler() {
    qDebug() << "Windows File Selection handler Constructor..............";
}
WindowsFileSelectionHandler::~WindowsFileSelectionHandler() {
    qDebug() << "Windows File Selection handler Destructor..............";
}

std::string WindowsFileSelectionHandler::getVideoFilePath() {
    std::string filePathAsCPPString("");
    HRESULT hr = CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);

    if (SUCCEEDED(hr))
    {
        IFileOpenDialog *pFileOpen;

        // Create the FileOpenDialog object.
        hr = CoCreateInstance(CLSID_FileOpenDialog, NULL, CLSCTX_ALL,
                              IID_IFileOpenDialog, reinterpret_cast<void**>(&pFileOpen));

        if (SUCCEEDED(hr))
        {
            COMDLG_FILTERSPEC rgSpec[] =
            {
                { L"videos", L"*.mp4;*.mkv" }
            };
            hr = pFileOpen->SetFileTypes(1, rgSpec);
            if (SUCCEEDED(hr))
            {
                // Show the Open dialog box.
                hr = pFileOpen->Show(NULL);

                // Get the file name from the dialog box.
                if (SUCCEEDED(hr))
                {
                    IShellItem *pItem;
                    hr = pFileOpen->GetResult(&pItem);
                    if (SUCCEEDED(hr))
                    {
                        PWSTR pszFilePath;
                        hr = pItem->GetDisplayName(SIGDN_FILESYSPATH, &pszFilePath);

                        // Display the file name to the user.
                        if (SUCCEEDED(hr))
                        {
                            //                        MessageBoxW(NULL, pszFilePath, L"File Path", MB_OK);
                            std::wstring ws(pszFilePath);
                            // your new String
                            filePathAsCPPString = std::string(ws.begin(), ws.end());
                            // Show String
                            std::cout << filePathAsCPPString << std::endl;
                            CoTaskMemFree(pszFilePath);
                        }
                        pItem->Release();
                    }
                }
            }
            pFileOpen->Release();
        }
        CoUninitialize();
    }
    return filePathAsCPPString;
}

void WindowsFileSelectionHandler::openDialog() {
}
