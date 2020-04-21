
sc stop LicenseManager && echo "microsoft shop"
sc stop NcbService
sc stop SecurityHealthService 

schtasks /delete  /f /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /delete  /f /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
schtasks /delete  /f /tn "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
schtasks /delete  /f /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /delete  /f /tn "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
schtasks /delete  /f /tn "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
schtasks /delete  /f /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
schtasks /delete  /f /tn "\Microsoft\Windows\Autochk\Proxy"

sc stop wuauserv && echo "windows update"
sc delete WaaSMedicSvc && echo "windows medic update"
sc stop usosvc && echo "windows Orchestrator update"

schtasks /end /tn "\MySQL\Installer\ManifestUpdate"

schtasks /end /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
schtasks /end /tn "\Microsoft\Windows\WindowsUpdate\sihpostreboot"
schtasks /delete /f /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
schtasks /delete /f /tn "\Microsoft\Windows\WindowsUpdate\sihpostreboot"
schtasks /delete /f /tn "\Microsoft\Windows\WindowsUpdate"

echo finished
