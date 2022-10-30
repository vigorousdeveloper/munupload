echo " ==============================================================================";

echo "=============Fetching latest version============="
rm -rf $HOME/mun
cd $HOME && git clone https://github.com/munblockchain/mun
echo "=============Compiling binary============="
cd $HOME/mun && make install
mund version
echo "=============Preparing binary upgrades============="
cd $HOME/.mun/upgrade_manager/upgrades && mkdir mun-upgrade-v2 && cd mun-upgrade-v2 && mkdir bin
cp $HOME/go/bin/mund $HOME/.mun/upgrade_manager/upgrades/mun-upgrade-v2/bin/
echo "=============Upgrading service configration============="
sudo sed -i 's/=on/=true/g' /etc/systemd/system/mund.service
sudo sed -i 's/=true-/=on-/g' /etc/systemd/system/mund.service
echo "=============Daemon reloading============="
sudo systemctl daemon-reload
sudo systemctl restart mund.service
echo "=============Done! Please wait until it reaches to upgrade block============="