mozilla-firefox-accounts Cookbook
=================================

Setz up
- fxa-auth-db-server (mysql)
- fxa-auth-server
- fxa-content-server


Derived from https://thomas-leister.de/internet/ubuntu-firefox-sync-1-5-server-installieren/
and from https://known.phyks.me/2015/self-hosting-firefox-sync-15

Requirements
------------

#### packages
- `certificate` - manages certificate via data_bag
- `nodejs`

Attributes
----------

#### mozilla-firefox-accounts::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mozilla-firefox-accounts']['database']</tt></td>
    <td>Array</td>
    <td>Hold your database credentials</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['mozilla-firefox-accounts']*['version']</tt></td>
    <td>String</td>
    <td>Branch or Commit from github to install</td>
    <td><tt>train-31</tt></td>
  </tr>
  <tr>
    <td><tt>['mozilla-firefox-accounts']*['version']</tt></td>
    <td>String</td>
    <td>Branch or Commit from github to install</td>
    <td><tt>train-31</tt></td>
  </tr>
  </tr>
  <tr>
    <td><tt>['mozilla-firefox-accounts']['content-server']['secret']</tt></td>
    <td>String</td>
    <td>Secret for content server</td>
    <td><tt>autogenerated</tt></td>
  </tr>
  <tr>
    <td><tt>['mozilla-firefox-sync']['content-server']['use_https'] </tt></td>
    <td>Boolean</td>
    <td>if activated, a data bag with the certificate is needed</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### mozilla-firefox-accounts::default

Just include `mozilla-firefox-accounts::fxa-auth-server` and/or `mozilla-firefox-accounts::fxa-content-server` in your node's `run_list`:

TODO
------------

- Add init Scripts for Debian


Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Christian Fischer, computerlyrik
