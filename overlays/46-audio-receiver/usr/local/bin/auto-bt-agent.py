#!/usr/bin/env python3

import sys
from pydbus import SystemBus
from gi.repository import GLib, Gio

class AutoAgent:
    def __init__(self, path):
        self.path = path

    def Release(self):
        pass

    def RequestPinCode(self, device):
        return "0000"

    def DisplayPinCode(self, device, pincode):
        pass

    def RequestPasskey(self, device):
        return 0

    def DisplayPasskey(self, device, passkey, entered):
        pass

    def RequestConfirmation(self, device, passkey):
        return

    def RequestAuthorization(self, device):
        return

    def AuthorizeService(self, device, uuid):
        print(f"AuthorizeService called with device: {device} and uuid: {uuid}")
        allowed_services = [
            "0000110d-0000-1000-8000-00805f9b34fb",  # UUID for A2DP
            "0000110e-0000-1000-8000-00805f9b34fb"   # UUID for AVRCP
        ]
        if uuid in allowed_services:
            print(f"Authorizing service {uuid}")
            return
        else:
            print(f"Denying service {uuid}")
            raise Exception("Service not authorized")

    def Cancel(self):
        pass

if __name__ == "__main__":
    bus = SystemBus()
    bus_name = "com.auto.agent"
    object_path = "/com/auto/agent"
    agent = AutoAgent(object_path)

    # Load the introspection XML
    with open("/usr/local/bin/bt-agent.xml", "r") as f:
        INTROSPECTION_XML = f.read()

    # Register the object using the introspection data
    bus.register_object(object_path, agent, [INTROSPECTION_XML])

    agent_manager = bus.get("org.bluez", "/org/bluez")
    agent_manager.RegisterAgent(object_path, "NoInputNoOutput")
    agent_manager.RequestDefaultAgent(object_path)

    loop = GLib.MainLoop()
    loop.run()